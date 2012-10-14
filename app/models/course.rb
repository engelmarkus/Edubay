# coding: utf-8
require "utils"

# Repräsentiert eine Veranstaltung aus TUMonline.
#
# In der internen Datenbank werden lediglich zwei Werte gespeichert:
# * die ID der Veranstaltung, die auch in der TUMonline-Datenbank verwendet wird
# * ein Wert, der angibt, ob alle oder nur auf TUMonline angemeldete Benutzer die Veranstaltung sehen können
# Alle anderen Daten werden direkt vom CAMPUSonline-Webservice abgerufen oder aus dem lokalen Cache geholt,
# wenn sie benötigt werden.
class Course < ActiveRecord::Base
  has_many :documents, dependent: :destroy
  attr_accessible :id, :visible_to_all
  
  validates :id, presence: true, uniqueness: true
  validate :id_is_a_valid_courseID
  
  after_create :create_folder
  after_destroy :delete_folder
  
  
  # Prüft beim Anlegen eines Datensatzes, ob die übergebene ID auch vom CAMPUSonline-Webservice
  # gefunden wird, das heißt, ob sie eine Veranstaltung repräsentiert.
  def id_is_a_valid_courseID
    begin
      CAMPUSonline.getCourse(id)
    rescue CAMPUSonline::NotFound
      errors.add(:id, "ist keine gültige TUMonline-courseID")
    end
  end
    
  # Der Name der Veranstaltung.
  def name
    return cached_attribute(:name)
  end
  
  # Das Semester, in dem die Veranstaltung stattfindet.
  def teaching_term
    return cached_attribute(:teachingTerm)
  end
  
  # Ein Array mit den Namen der Vortragenden.
  def lecturers
    return cached_attribute(:lecturers)
  end
  
  # Ein Array mit Daten, an denen die Veranstaltung stattfindet bzw. stattgefunden hat.
  # Da diese Datumsangaben nur beim Erstellen eines neuen Dokuments benötigt werden,
  # werden sie nicht gecacht.
  def dates
    @dates ||= CAMPUSonline.getEventsOfCourse(id)['RDM']['resource']['description']['resourceGroup']['description']['resource'].map {
      # nur Startzeiten extrahieren
      |hash| hash['description']['attribute'].select {
        |attr| attr['cor:attrID'] == 'dtstart'
      }
    }.map {
      # Inhalt der Knoten in Date-Objekte umwandeln
      |dtstart| Date.parse(dtstart[0]['__content__'])
    }.sort! {
      # Nach Datum sortieren
      |a, b| a <=> b
    }.uniq # Doppelte Einträge entfernen
    
    return @dates
  end


  # ########################
  # Methoden zum Management des lokalen Caches für CAMPUSonline-Daten.
  # ########################
  # TODO: gehört das eher in die CAMPUSonline-Klasse?
  # TODO: anderen Cache verwenden, bei dem sich mehrere Instanzen die Daten teilen können?
  
  # Der globale Cache, in dem Veranstaltungsdaten vom CAMPUSonline-Web Service zwischengespeichert werden.
  @@campusonline_cache = ActiveSupport::Cache::MemoryStore.new(expires_in: Edubay::Application.config.cache_expiration, race_condition_ttl: 10.seconds)
  
  # Wird benutzt, um alle Informationen zur Veranstaltung auf einmal vom Webservice zu holen und zwischenzuspeichern,
  # sodass nicht mehrere getrennte Aufrufe notwendig sind, wenn mehrere Attribute benötigt werden.
  def cache_campusonline_data()
    logger.debug "Called cache_campusonline_data for #{id}."

    # Daten vom Web Service holen.
    data = CAMPUSonline.getCourse(id)
    
    name = data['CDM']['course']['courseName']['text']
    teachingTerm = data['CDM']['course']['teachingTerm']
    
    # Die Vortragenden brauchen eine Extrabehandlung...
    # Wenn in der Liste nur 1 Vortragender steht, gibt der Web Service kein Array zurück, sondern einen
    # einzelnen Hash. Daher diesen Hash ggf. vor der Weiterverarbeitung in ein Array verpacken.
    lecturers = data['CDM']['course']['contacts']['person']
    lecturers = [lecturers] unless lecturers.kind_of?(Array)
    
    lecturers = lecturers.map { |p| "#{p['name']['family']} #{p['name']['given']}" }

    # Eintrag im Cache erzeugen.    
    @@campusonline_cache.write(id, { name: name, teachingTerm: teachingTerm, lecturers: lecturers })
    
    return @@campusonline_cache.fetch(id)
  end
  
  # Versucht, das Attribut "key" aus dem Cache zu holen bzw. erzwingt ein Aktualisieren des Caches,
  # wenn die Daten darin abgelaufen oder nicht vorhanden sind.  
  def cached_attribute(key)
    data = @@campusonline_cache.fetch(id) do
      logger.debug "Cache miss when trying to access attribute #{key} of course #{id}."
      cache_campusonline_data()
    end
    
    return data[key]
  end
  
  
  # ########################
  # Methoden zum Management des Ordners für die hochgeladenen Dateien
  # ########################
  
  # Ermittelt den Pfad des Ordners, in dem alle Dateien gespeichert werden, die zu dieser Veranstaltung hochgeladen wurden.
  def folder
    return File.join("uploads/", Utils.sanitize_filename(id))
  end
  
  # Erstellt beim Erzeugen eines Datensatzes den dazugehörigen Ordner für die Uploads.
  def create_folder
    if not Dir.exists?(folder)
      begin
        Dir.mkdir(folder)
        logger.info "Successfully created folder for course: #{folder}"
      rescue SystemCallError => e
        logger.warn "#{e}"
        return false
      end
    end
  end
  
  # Löscht beim Zerstören des Datensatzes den Ordner mit den hochgeladenen Dateien.
  def delete_folder
    begin
      Dir.delete(folder)
      logger.info "Successfully deleted folder for course: #{folder}"
    rescue SystemCallError => e
      logger.warn "#{e}"
    end
  end
end

# coding: utf-8
class Seminar
  # ########################
  # Methoden zum Management des lokalen Caches für CAMPUSonline-Daten.
  # ########################
  # TODO: gehört das eher in die CAMPUSonline-Klasse?
  # TODO: anderen Cache verwenden, bei dem sich mehrere Instanzen die Daten teilen können?
  
  # Der globale Cache, in dem Veranstaltungsdaten vom CAMPUSonline-Web Service zwischengespeichert werden.
  @@campusonline_cache = ActiveSupport::Cache::MemoryStore.new(expires_in: Edubay::Application.config.cache_expiration, race_condition_ttl: 10.seconds)
  
  # Wird benutzt, um alle Informationen zur Veranstaltung auf einmal vom Webservice zu holen und zwischenzuspeichern,
  # sodass nicht mehrere getrennte Aufrufe notwendig sind, wenn mehrere Attribute benötigt werden.
  def self.cache_campusonline_data()
    #logger.debug "Called cache_campusonline_data"

    # Daten vom Web Service holen.
    data = CAMPUSonline.getNextYearsCoursesOfOrganisation('14189')
    
    #data = CAMPUSonline.getCourse('950112827')
    
    @@campusonline_cache.write(1, data.body)
    
    #name = data['CDM']['course']['courseName']['text']
    #teachingTerm = data['CDM']['course']['teachingTerm']
    
    # Die Vortragenden brauchen eine Extrabehandlung...
    # Wenn in der Liste nur 1 Vortragender steht, gibt der Web Service kein Array zurück, sondern einen
    # einzelnen Hash. Daher diesen Hash ggf. vor der Weiterverarbeitung in ein Array verpacken.
    #lecturers = data['CDM']['course']['contacts']['person']
    #lecturers = [lecturers] unless lecturers.kind_of?(Array)
    
    #lecturers = lecturers.map { |p| "#{p['name']['family']} #{p['name']['given']}" }

    # Eintrag im Cache erzeugen.    
    #@@campusonline_cache.write(id, { name: name, teachingTerm: teachingTerm, lecturers: lecturers })
    
    return @@campusonline_cache.fetch(1)
  end
  
  # Versucht, das Attribut "key" aus dem Cache zu holen bzw. erzwingt ein Aktualisieren des Caches,
  # wenn die Daten darin abgelaufen oder nicht vorhanden sind.  
  def self.cached_attribute()
    data = @@campusonline_cache.fetch(1) do
      #logger.debug "Cache miss." # when trying to access attribute #{key} of course #{id}."
      cache_campusonline_data()
    end
    
    return data
  end  
end
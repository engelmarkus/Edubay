# Diese Klasse dient zum Zugriff auf CAMPUSonline-Systeme.
# CAMPUSonline stellt einen XML-Webservice zur Verfügung, über den Informationen zu Vorlesungen,
# Organisationen, Teilnehmern, etc. ausgelesen werden können.
#
# Dazu wird ein Token benötigt, das in der Konfigurationsdatei 'config/edubay.yml' festgelegt werden muss.
#
# Bei Erfolg wird jeweils ein XML-Dokument zurückgegeben, das dem {CDM-Schema}[http://utdanning.no/schemas/CDM/2/CDM.xsd]
# entspricht. Bei einem Fehler sieht das Dokument folgendermaßen aus:
#   <?xml version="1.0" encoding="utf-8"?>
#   <Error>
#     ...
#     <Message>...</Message>
#   </Error>
class CAMPUSonline
  include HTTParty
  base_uri 'https://campus.tum.de/tumonlinej/ws/webservice_v1.0'
  default_params token: Edubay::Application.config.campusonline_token
  
  # Parser abschalten, wird später von was anderem übernommen
  format :plain
 
  # Wird benutzt, um einen Fehler "400" beim Aufruf des Web-Services anzuzeigen.
  #
  # Wird normalerweise ausgelöst, wenn die übergebenen Parameter ungültig waren, bzw. ein benötigter Parameter gefehlt hat.
  class BadRequest < RuntimeError; end
  
  # Wird benutzt, um einen Fehler "404" beim Aufruf des Web-Services anzuzeigen.
  #
  # Wird normalerweise ausgelöst, wenn kein Datensatz zu einer übergebenen ID gefunden wurde.
  class NotFound < RuntimeError; end

  # Wird benutzt, um einen unbekannten Fehler (alle außer "400" bzw. "404") beim Aufruf des Web-Services anzuzeigen.
  class UnknownError < RuntimeError; end
  
  class << self
    # Der globale Cache, in dem Daten vom CAMPUSonline-Web Service zwischengespeichert werden.
    @@cache = ActiveSupport::Cache::FileStore.new('tmp/cache/campusonline', expires_in: Edubay::Application.config.cache_expiration)
    
    # Holt Daten aus dem Cache, bzw. vom Web Service, wenn keine aktuellen Daten vorhanden sind.
    #
    # * *Parameter*:
    #   - +url+ -> die Teiladresse der zu holenden Daten
    #   - +params+ -> beim Abrufen von der Adresse zu übergebende Parameter
    # * *Rückgabewert*:
    #   - String mit XML-Dokument
    # * *Ausnahmen*:
    #   - siehe BadRequest
    #   - siehe NotFound
    #   - siehe UnknownError
    def fetch(url, params = {})
      # Erst prüfen, ob aktuelle Daten im Cache vorhanden sind.
      data = @@cache.fetch(Digest::MD5.hexdigest(url + '/' + params.to_s)) do
        # Wenn nicht, Anfrage schicken
        response = get(url, query: params)
        
        raise BadRequest, response if response.code == 400
        raise NotFound, response if response.code == 404
        raise UnknownError, response unless response.code == 200
        
        response.body
      end
      
      return data
    end
    
    # Ermittelt Informationen zu einer Veranstaltung.
    #
    # * *Parameter*:
    #   - +courseID+ -> die ID der Veranstaltung
    # * *Rückgabewert*:
    #   - String mit XML-Dokument
    # * *Ausnahmen*:
    #   - siehe ::fetch
    def getCourse(courseID, lang)
      fetch('/cdm/course/xml', courseID: courseID, language: lang)
    end
    
    # Ermittelt eine Liste aller Veranstaltungen einer Organisation.
    #
    # * *Parameter*:
    #   - +orgUnitID+ -> die ID der Organisation
    # * *Rückgabewert*:
    #   - String mit XML-Dokument
    # * *Ausnahmen*:
    #   - siehe ::fetch
    def getCoursesOfOrganisation(orgUnitID, term, lang)
      fetch('/cdm/organization/courses/xml', orgUnitID: orgUnitID, teachingTerm: term, language: lang)
    end

    # Ermittelt eine Liste aller Veranstaltungen einer Organisation im nächsten Semester.
    #
    # * *Parameter*:
    #   - +orgUnitID+ -> die ID der Organisation
    # * *Rückgabewert*:
    #   - String mit XML-Dokument
    # * *Ausnahmen*:
    #   - siehe ::fetch
    def getNextYearsCoursesOfOrganisation(orgUnitID)
      fetch('/cdm/organization/courses/nextyear/xml', orgUnitID: orgUnitID)
    end

    # Ermittelt eine Liste aller Veranstaltungen, die von einer Person angeboten werden.
    #
    # * *Parameter*:
    #   - +personID+ -> die ID der Person
    # * *Rückgabewert*:
    #   - String mit XML-Dokument
    # * *Ausnahmen*:
    #   - siehe ::fetch
    def getCoursesOfPerson(personID)
      fetch('/cdm/person/courses/xml', personID: personID)
    end
    
    # Ermittelt eine Liste aller Abhaltungstermine einer Veranstaltung.
    #
    # * *Parameter*:
    #   - +courseID+ -> die ID der Veranstaltung
    # * *Rückgabewert*:
    #   - String mit XML-Dokument
    # * *Ausnahmen*:
    #   - siehe ::fetch
    def getEventsOfCourse(courseID)
      fetch('/rdm/course/events/xml', courseID: courseID)
    end
    
    # Ermittelt eine Liste aller zu einer Veranstaltung angemeldeten Studenten.
    #
    # * *Parameter*:
    #   - +courseID+ -> die ID der Veranstaltung
    # * *Rückgabewert*:
    #   - String mit XML-Dokument
    # * *Ausnahmen*:
    #   - siehe ::fetch
    def getStudentsOfCourse(courseID)
      fetch('/cdm/course/students/xml', courseID: courseID)
    end
  end
end

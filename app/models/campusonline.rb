# Diese Klasse dient zum Zugriff auf CAMPUSonline-Systeme.
# CAMPUSonline stellt einen XML-Webservice zur Verfügung, über den Informationen zu Vorlesungen,
# Organisationen, Teilnehmern, etc. ausgelesen werden können.
#
# Dazu wird ein Token benötigt, das beim Aufruf einer Funktion jeweils mit übergeben werden muss.
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
  ssl_version :SSLv3
 
  @@token = "### your_secret_token_here ###"

  # Wird benutzt, um einen Fehler "400" beim Aufruf des Web-Services anzuzeigen.
  #
  # Wird normalerweise ausgelöst, wenn die übergebenen Parameter ungültig waren, bzw. ein benötigter Parameter gefehlt hat.
  class BadRequest < RuntimeError; end
  
  # Wird benutzt, um einen unbekannten Fehler (alle außer "400" bzw. "404") beim Aufruf des Web-Services anzuzeigen.
  class UnknownError < RuntimeError; end
  
  # Wird benutzt, um einen Fehler "404" beim Aufruf des Web-Services anzuzeigen.
  #
  # Wird normalerweise ausgelöst, wenn kein Datensatz zu einer übergebenen ID gefunden wurde.
  class NotFound < RuntimeError; end

  class << self
    def fetch(url, params = {})
      params[:token] = @@token
      response = get(url, query: params)
      
      raise BadRequest, response if response.code == 400
      raise NotFound, response if response.code == 404
      raise UnknownError, response unless response.code == 200
      
      return response
    end
    
    # Ermittelt Informationen zu einer Veranstaltung.
    #
    # * *Parameters*:
    #   - +courseID+ -> die ID der Veranstaltung
    # * *Returns*:
    #   - Hash mit Informationen
    # * *Raises*:
    #   - siehe ::fetch
    def getCourse(courseID)
      fetch('/cdm/course/xml', courseID: courseID)
    end
    
    # Ermittelt eine Liste aller Veranstaltungen einer Organisation.
    #
    # * *Parameters*:
    #   - +orgUnitID+ -> die ID der Organisation
    # * *Returns*:
    #   - Hash mit Informationen
    # * *Raises*:
    #   - siehe ::fetch
    def getCoursesOfOrganisation(orgUnitID)
      fetch('/cdm/organization/courses/xml', orgUnitID: orgUnitID)
    end

    # Ermittelt eine Liste aller Veranstaltungen, die von einer Person angeboten werden.
    #
    # * *Parameters*:
    #   - +personID+ -> die ID der Person
    # * *Returns*:
    #   - Hash mit Informationen
    # * *Raises*:
    #   - siehe ::fetch
    def getCoursesOfPerson(personID)
      fetch('/cdm/person/courses/xml', personID: personID)
    end
    
    # Ermittelt eine Liste aller Abhaltungstermine einer Veranstaltung.
    #
    # * *Parameters*:
    #   - +courseID+ -> die ID der Veranstaltung
    # * *Returns*:
    #   - Hash mit Informationen
    # * *Raises*:
    #   - siehe ::fetch
    def getEventsOfCourse(courseID)
      fetch('/rdm/course/events/xml', courseID: courseID)
    end
    
    # Ermittelt eine Liste aller zu einer Veranstaltung angemeldeten Studenten.
    #
    # * *Parameters*:
    #   - +courseID+ -> die ID der Veranstaltung
    # * *Returns*:
    #   - Hash mit Informationen
    # * *Raises*:
    #   - siehe ::fetch
    def getStudentsOfCourse(courseID)
      fetch('/cdm/course/students/xml', courseID: courseID)
    end
  end
end

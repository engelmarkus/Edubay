require 'net/http'

module EdubayApi
  class WebService
    attr_reader :url

    def initialize(url="http://localhost:3000")
      @url = url
    end

    def create(object)
      uri = URI.parse @url + object.class.address + ".xml"

      request = Net::HTTP::Post.new(uri.to_s)
      request.content_type = 'application/xml'
      request.body = "<?xml version='1.0' encoding='UTF-8'?>#{object.xml}"

      http = Net::HTTP.new(uri.host, uri.port)

      response = http.request(request)
      response
      
      # 406 Not Acceptable wenn Speichern auf dem Server fehlgeschlagen, .body beinhaltet Fehlermeldungen
      # 201 Created wenn Datensatz angelegt werden konnte
    end
    
    def readOne(type, id)
      uri = URI.parse @url + type.address

      request = Net::HTTP.new(uri.host, uri.port)
      
      response = request.get("#{uri.path}/#{id}.xml")
      response
      
      # 200 OK und XML in response.body
      # 404 Not Found
    end
    
    def readAll(type)
      uri = URI.parse @url + type.address
      
      request = Net::HTTP.new(uri.host, uri.port)
      
      response = request.get("#{uri.path}.xml")
      response
      
      # 200 OK und XML in response.body
      # 404 Not Found
    end
    
    def update(type, id, object)
      uri = URI.parse @url + type.address

      request = Net::HTTP::Put.new("#{uri.path}/#{id}.xml")
      request.content_type = 'application/xml'
      request.body = "<?xml version='1.0' encoding='UTF-8'?>#{object.xml}"

      http = Net::HTTP.new(uri.host, uri.port)

      response = http.request(request)
      response
      
      # 406 Not Acceptable wenn Update auf dem Server fehlgeschlagen, .body beinhaltet Fehlermeldungen
      # 201 Created wenn Datensatz aktualisiert werden konnte
    end
    
    def delete(type, id)
      uri = URI.parse @url + type.address
      
      request = Net::HTTP::Delete.new("#{uri.path}/#{id}.xml")
      http = Net::HTTP.new(uri.host, uri.port)
      
      response = http.request(request)
      response
      
      # 200 OK
      # 404 Not Found
    end
  end

  class Term
    attr_reader :id
    attr_reader :name

    def initialize(id=nil, name)
      @id = id
      @name = name
    end

    def self.address
      "/terms"
    end

    def xml
      "<term>
        <id>#{@id}</id>
        <name>#{@name}</name>
      </term>"
    end
  end
end

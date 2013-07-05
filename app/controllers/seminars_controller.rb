class SeminarsController < ApplicationController
  # GET /seminar
  def index
    @daten = Nokogiri::XML(Seminar.cached_attribute()) #(File.read('app/views/seminars/data.xml'))
    @daten = @daten.xpath('//course')
    
    respond_to do |format|
      format.html { render file: 'seminars/seminars.html.erb' }
    end
  end
end

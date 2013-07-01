class SeminarsController < ApplicationController
  # GET /seminar
  def index
    seminarliste_xml = Nokogiri::XML(Seminar.cached_attribute())
    xslt = Nokogiri::XSLT(File.read('app/views/seminare/seminare.xslt'))
    
    @daten = xslt.transform(seminarliste_xml)
    
    respond_to do |format|
      format.html { render text: @daten, layout: true } # index.html.erb
    end
  end
end

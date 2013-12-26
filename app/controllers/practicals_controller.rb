class PracticalsController < ApplicationController
  # GET /practicals/bachelor
  def bachelor
    @daten = Nokogiri::XML(CAMPUSonline.getCoursesOfOrganisation('14189')).xpath('//course')
    @lvnr = 'IN0012'
    
    respond_to do |format|
      format.html { render file: 'practicals/practicals.html.erb' }
    end
  end
  
  # GET /practicals/master
  def master
    @daten = Nokogiri::XML(CAMPUSonline.getCoursesOfOrganisation('14189')).xpath('//course')
    @lvnr = 'IN2106'
    
    respond_to do |format|
      format.html { render file: 'practicals/practicals.html.erb' }
    end
  end
end

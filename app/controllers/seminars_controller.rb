class SeminarsController < ApplicationController
  def getData(courseNumber)
    # Liste aller gesuchten Veranstaltungen
    overview = Nokogiri::XML(CAMPUSonline.getNextYearsCoursesOfOrganisation('14189')).xpath("//course[contains(courseName/text, '#{courseNumber}')]")
    
    # Für jede einzelne noch Details abrufen
    details = {}
    
    overview.each do |course|
      courseID = course.xpath('courseID').inner_text
      details[courseID] = Nokogiri::XML(CAMPUSonline.getCourse(courseID))
    end
    
    return overview, details
  end
  
  # GET /seminars/bachelorpro
  def bachelorpro
    @overview, @details = getData("IN0013")
    
    respond_to do |format|
      format.html { render file: 'seminars/seminars.html.erb' }
    end
  end
  
  # GET /seminars/bachelor
  def bachelor
    @overview, @details = getData("IN0014")
    
    respond_to do |format|
      format.html { render file: 'seminars/seminars.html.erb' }
    end
  end
  
  # GET /seminars/master
  def master
    @overview, @details = getData("IN2107")
    
    respond_to do |format|
      format.html { render file: 'seminars/seminars.html.erb' }
    end
  end
end

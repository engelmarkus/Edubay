class PracticalsController < ApplicationController
  def getData(courseNumber, semester)
    # Liste aller gesuchten Veranstaltungen
    if semester == "next" then
      courses = CAMPUSonline.getNextYearsCoursesOfOrganisation('14189')
    else
      courses = CAMPUSonline.getCoursesOfOrganisation('14189')
    end
    
    overview = Nokogiri::XML(courses).xpath("//course[contains(courseName/text, '#{courseNumber}')]")
    
    # Für jede einzelne noch Details abrufen
    details = {}
    termine = {}
    
    overview.each do |course|
      courseID = course.xpath('courseID').inner_text
      
      details[courseID] = Nokogiri::XML(CAMPUSonline.getCourse(courseID))
      
      termin = Nokogiri::XML(CAMPUSonline.getEventsOfCourse(courseID))
      termin.remove_namespaces!
      
      termine[courseID] = termin.xpath('//resource[@typeID="singleEvent"]').min_by { |node| node.xpath('description/attribute[@attrID="dtstart"]').text }
    end
    
    return overview, details, termine
  end
  
  # GET /practicals/bachelor
  def bachelor
    @overview, @details, @termine = getData("IN0012", params[:semester])
    
    respond_to do |format|
      format.html { render file: 'practicals/practicals.html.erb' }
    end
  end
  
  # GET /practicals/master
  def master
    @overview, @details, @termine = getData("IN2106", params[:semester])
    
    respond_to do |format|
      format.html { render file: 'practicals/practicals.html.erb' }
    end
  end
end

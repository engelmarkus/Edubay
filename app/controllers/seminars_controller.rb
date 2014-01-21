class SeminarsController < ApplicationController
  def getData(courseNumber, semester, lang)
    # Liste aller gesuchten Veranstaltungen
    if semester == "next" then
      courses = CAMPUSonline.getCoursesOfOrganisation('14189', :S, lang)
    else
      courses = CAMPUSonline.getCoursesOfOrganisation('14189', :W, lang)
    end
    
    overview = Nokogiri::XML(courses).xpath("//course[contains(courseName/text, '#{courseNumber}')]")
    
    # Für jede einzelne noch Details abrufen
    details = {}
    termine = {}
    
    overview.each do |course|
      courseID = course.xpath('courseID').inner_text
      
      details[courseID] = Nokogiri::XML(CAMPUSonline.getCourse(courseID, lang))
      
      termin = Nokogiri::XML(CAMPUSonline.getEventsOfCourse(courseID))
      termin.remove_namespaces!
      
      termine[courseID] = termin.xpath('//resource[@typeID="singleEvent"]').min_by { |node| node.xpath('description/attribute[@attrID="dtstart"]').text }
    end
    
    return overview, details, termine
  end
  
  # GET /seminars/bachelorpro
  def bachelorpro
    @overview, @details, @termine = getData("IN0013", params[:semester], I18n.locale)
    
    respond_to do |format|
      format.html { render file: 'seminars/seminars.html.erb' }
    end
  end
  
  # GET /seminars/bachelor
  def bachelor
    @overview, @details, @termine = getData("IN0014", params[:semester], I18n.locale)
    
    respond_to do |format|
      format.html { render file: 'seminars/seminars.html.erb' }
    end
  end
  
  # GET /seminars/master
  def master
    @overview, @details, @termine = getData("IN2107", params[:semester], I18n.locale)
    
    respond_to do |format|
      format.html { render file: 'seminars/seminars.html.erb' }
    end
  end
end

class Course < ActiveRecord::Base
  def self.updateDb
    courses = Nokogiri::XML(CAMPUSonline.getCoursesOfOrganisation('14189', :S, 'en')).xpath('//course')
    
    courses.each do |course| 
      courseID = course.xpath('courseID').inner_text
      
      details = Nokogiri::XML(CAMPUSonline.getCourse(courseID, 'en'))
      
      name = course.xpath('courseName/text').inner_text
      admissionInfo = details.xpath("/CDM/course/admissionInfo/admissionDescription/text()").text
      
      lang = details.xpath("/CDM/course/instructionLanguage/@teachingLang")
      
      if lang == "English" then
        Course.new(courseID: courseID, courseName: name, admissionInfo: admissionInfo).save!        
      end
    end
  end
end

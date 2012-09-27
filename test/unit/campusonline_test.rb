require 'test_helper'

class CAMPUSonlineTest < ActiveSupport::TestCase
  @@courseID = '950073543'
  
  test "should fetch course data from server by id" do
    assert_nothing_raised(CAMPUSonline::BadRequest, CAMPUSonline::NotFound, CAMPUSonline::UnknownError) do
      data = CAMPUSonline.getCourseById(@@courseID)
      
      assert(data['CDM']['course']['courseID'] == @@courseID, "courseIDs do not match")
    end
  end
  
  test "should fail when trying to fetch course data due to empty or unknown id" do
    assert_raise(CAMPUSonline::NotFound) do
      data = CAMPUSonline.getCourseById(nil)
    end
    
    assert_raise(CAMPUSonline::NotFound) do
      data = CAMPUSonline.getCourseById("")
    end
    
    assert_raise(CAMPUSonline::NotFound) do
      data = CAMPUSonline.getCourseById(1)
    end
  end
end

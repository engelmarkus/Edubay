class CoursesController < ApplicationController
  # GET /courses
  def index
    @courses = Course.all
    
    respond_to do |format|
      format.html { render file: 'courses/courses.html.erb' }
    end
  end
end

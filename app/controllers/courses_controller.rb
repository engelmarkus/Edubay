class CoursesController < ApplicationController
  before_filter :redirect_if_not_logged_in
  
  # GET /courses
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /courses/1
  def show
    @course = Course.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
end

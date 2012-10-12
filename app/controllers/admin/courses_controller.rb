class Admin::CoursesController < ApplicationController
  #before_filter :redirect_if_not_admin
  
  # GET /admin/courses
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/courses/1
  def show
    @course = Course.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  # GET /admin/courses/new
  def new
    @course = Course.new

    respond_to do |format|
      format.js { render content_type: Mime::HTML } # new.html.erb
    end
  end

  # GET /admin/courses/1/edit
  def edit
    @course = Course.find(params[:id])
    
    respond_to do |format|
      format.js { render content_type: Mime::HTML } # edit.html.erb
    end
  end

  # POST /admin/courses
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.js { render partial: 'single_table_row', object: @course, as: :course, content_type: Mime::HTML }
      else
        format.js { render partial: 'shared/error_messages', object: @course.errors,
          status: :unprocessable_entity, content_type: Mime::HTML }
      end
    end
  end

  # PUT /admin/courses/1
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.js { render partial: 'single_table_row', object: @course, as: :course, content_type: Mime::HTML }
      else
        format.js { render partial: 'shared/error_messages', object: @course.errors,
          status: :unprocessable_entity, content_type: Mime::HTML }
      end
    end
  end

  # DELETE /admin/courses/1
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to admin_courses_path }
    end
  end
end

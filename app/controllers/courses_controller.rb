class CoursesController < ApplicationController
  # GET /courses
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @courses }
    end
  end

  # GET /courses/1
  def show
    @course = Course.find(params[:id])

    @documents = @course.documents.find(:all)
    @documents_by_date = @documents.group_by { |doc| doc.lecture_date }
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @course }
    end
  end

  # GET /courses/new
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render status: :bad_request, content_type: "text/plain", text: "400 Bad request" }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.xml { head :created, :location => term_path(@course) }
      else
        format.html { render action: "new" }
        format.xml { render status: :not_acceptable, xml: @course.errors.full_messages }
      end
    end
  end

  # PUT /courses/1
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.xml { head :created, :location => term_path(@course) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :not_acceptable, xml: @course.errors.full_messages }
      end
    end
  end

  # DELETE /courses/1
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.xml { head :ok }
    end
  end
  
  # GET /courses/1/feed
  def feed
    @course = Course.find(params[:id])
    @recently_uploaded_files = Document.find_all_by_course_id(@course.id, order: 'created_at DESC', limit: 5)
    
    respond_to do |format|
      format.rss { render layout: false } # feed.rss.builder
    end
  end
end

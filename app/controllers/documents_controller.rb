class DocumentsController < ApplicationController
  # GET /documents
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /documents/1
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /documents/new
  def new
    @course = Course.find(params[:course_id])
    @document = Document.new(course_id: @course.id)

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  def create
    # extract file extension for storing
    file = params[:file]
    params[:document][:extension] = File.extname(params[:file].original_filename)
    params[:document][:user_id] = "huhu" #current_user.uid
    
    params[:document][:course_id] = params[:course_id]
    @course = Course.find(params[:course_id])
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        @document.store_uploaded_file(file)        
        
        format.html { redirect_to url_for([@course, @document]), notice: 'Document was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /documents/1
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /documents/1
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
    end
  end
end

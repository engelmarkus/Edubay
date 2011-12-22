class LecturersController < ApplicationController
  # GET /lecturers
  def index
    @lecturers = Lecturer.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /lecturers/1
  def show
    @lecturer = Lecturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /lecturers/new
  def new
    @lecturer = Lecturer.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /lecturers/1/edit
  def edit
    @lecturer = Lecturer.find(params[:id])
  end

  # POST /lecturers
  def create
    @lecturer = Lecturer.new(params[:lecturer])

    respond_to do |format|
      if @lecturer.save
        format.html { redirect_to @lecturer, notice: 'Lecturer was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /lecturers/1
  def update
    @lecturer = Lecturer.find(params[:id])

    respond_to do |format|
      if @lecturer.update_attributes(params[:lecturer])
        format.html { redirect_to @lecturer, notice: 'Lecturer was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /lecturers/1
  def destroy
    @lecturer = Lecturer.find(params[:id])
    @lecturer.destroy

    respond_to do |format|
      format.html { redirect_to lecturers_url }
      format.js   { render :nothing => true }
    end
  end
end

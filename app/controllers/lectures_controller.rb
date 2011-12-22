class LecturesController < ApplicationController
  # GET /lectures
  def index
    @lectures = Lecture.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /lectures/1
  def show
    @lecture = Lecture.find(params[:id])

    @documents = @lecture.documents.find(:all)
    @documents_by_date = @documents.group_by { |doc| doc.lecture_date }

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /lectures/1/edit
  def edit
    @lecture = Lecture.find(params[:id])
  end

  # POST /lectures
  def create
    @lecture = Lecture.new(params[:lecture])

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /lectures/1
  def update
    @lecture = Lecture.find(params[:id])

    respond_to do |format|
      if @lecture.update_attributes(params[:lecture])
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /lectures/1
  def destroy
    @lecture = Lecture.find(params[:id])
    @lecture.destroy

    respond_to do |format|
      format.html { redirect_to lectures_url }
    end
  end
end

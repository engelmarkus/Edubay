class LecturesController < ApplicationController
  # GET /lectures
  def index
    @lectures = Lecture.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @lectures }
    end
  end

  # GET /lectures/1
  def show
    @lecture = Lecture.find(params[:id])

    @documents = @lecture.documents.find(:all)
    @documents_by_date = @documents.group_by { |doc| doc.lecture_date }

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @lecture }
    end
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render status: :bad_request, content_type: "text/plain", text: "400 Bad request" }
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
        format.xml { head :created, :location => term_path(@lecture) }
      else
        format.html { render action: "new" }
        format.xml { render status: :not_acceptable, xml: @lecture.errors.full_messages }
      end
    end
  end

  # PUT /lectures/1
  def update
    @lecture = Lecture.find(params[:id])

    respond_to do |format|
      if @lecture.update_attributes(params[:lecture])
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.xml { head :created, :location => term_path(@lecture) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :not_acceptable, xml: @lecture.errors.full_messages }
      end
    end
  end

  # DELETE /lectures/1
  def destroy
    @lecture = Lecture.find(params[:id])
    @lecture.destroy

    respond_to do |format|
      format.html { redirect_to lectures_url }
      format.xml { head :ok }
    end
  end

  # GET /lectures/1/feed
  def feed
    @lecture = Lecture.find(params[:id])
    @recently_uploaded_files = Document.find_all_by_lecture_id(@lecture.id, order: 'created_at DESC', limit: 5)
    
    respond_to do |format|
      format.rss { render layout: false } # feed.rss.builder
    end
  end
end

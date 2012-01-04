class DocumentsController < ApplicationController
  # GET /documents
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @documents }
    end
  end

  # GET /documents/1
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @document }
    end
  end

  # GET /documents/new
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render status: :bad_request, content_type: "text/plain", text: "400 Bad request" }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.xml { head :created, :location => term_path(@document) }
      else
        format.html { render action: "new" }
        format.xml { render status: :not_acceptable, xml: @document.errors.full_messages }
      end
    end
  end

  # PUT /documents/1
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.xml { head :created, :location => term_path(@document) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :not_acceptable, xml: @document.errors.full_messages }
      end
    end
  end

  # DELETE /documents/1
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.xml { head :ok }
    end
  end
  
  # GET /documents/1/download
  def download
    send_file 'uploaded_files/test.txt', :type => 'text/txt'
  end
  
  # GET /documents/feed
  def feed
    @recently_uploaded_files = Document.find(:all, :order => 'created_at DESC', :limit => 10)
    
    respond_to do |format|
      format.rss { render layout: false } # feed.rss.builder
    end
  end
end

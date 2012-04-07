class DocumentsController < ApplicationController
  before_filter :redirect_if_not_admin, except: ['index', 'show', 'download']
  before_filter :redirect_if_not_logged_in, only: ['download']
  
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
      format.xml { render xml: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  def create
    # extract file extension for storing
    file = params[:fileToUpload]
    params[:document][:file_extension] = File.extname(params[:fileToUpload].original_filename)
    params[:document][:uploader_id] = @current_user.uid
    
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        @document.store_file_on_create(file)
      
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.xml { head :created, location: document_path(@document) }
        format.js
      else
        format.html { render action: "new" }
        format.xml { render status: :unprocessable_entity, xml: @document.errors.full_messages }
        format.js
      end
    end
  end

  # PUT /documents/1
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.xml { head :created, location: document_path(@document) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :unprocessable_entity, xml: @document.errors.full_messages }
      end
    end
  end

  # DELETE /documents/1
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      if @document.destroy
        format.html { redirect_to documents_url }
        format.any(:xml, :js) { head :ok }
      else
        format.html { redirect_to documents_url }
        format.xml { render status: :conflict }
        format.js { render status: :conflict, text: "There was an error deleting this document." }
      end
    end
  end
  
  # GET /documents/1/download
  def download
    @document = Document.find(params[:id])
    #send_file 'uploaded_files/test.txt', :type => 'text/txt'
    path = File.join(@document.lecture.get_folder(), Utils.sanitize_filename(@document.lecture_date.to_s), Utils.sanitize_filename(@document.doc_type.name + '_' + @document.id.to_s + @document.file_extension))
    
    #path = File.join(@document.lecture.get_folder(), Utils.sanitize_filename(@document.lecture_date.to_s), Utils.sanitize_filename(@document.doc_type.name + '_' + @document.id.to_s + ".pdf"))
    send_file path
  end
end

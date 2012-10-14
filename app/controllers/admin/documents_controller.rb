class Admin::DocumentsController < ApplicationController
  before_filter :redirect_if_not_admin
  
  # GET /admin/documents
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/documents/1
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /admin/documents/new
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /admin/documents
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /admin/documents/1
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

  # DELETE /admin/documents/1
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
    end
  end
end

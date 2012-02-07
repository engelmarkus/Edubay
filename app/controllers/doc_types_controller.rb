class DocTypesController < ApplicationController
  # GET /doc_types
  def index
    @doc_types = DocType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @doc_types }
    end
  end

  # GET /doc_types/1
  def show
    @doc_type = DocType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @doc_type }
    end
  end

  # GET /doc_types/new
  def new
    @doc_type = DocType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml: @doc_type }
    end
  end

  # GET /doc_types/1/edit
  def edit
    @doc_type = DocType.find(params[:id])
  end

  # POST /doc_types
  def create
    @doc_type = DocType.new(params[:doc_type])

    respond_to do |format|
      if @doc_type.save
        format.html { redirect_to @doc_type, notice: 'Doc type was successfully created.' }
        format.xml { head :created, location: doc_type_path(@doc_type) }
      else
        format.html { render action: "new" }
        format.xml { render status: :unprocessable_entity, xml: @doc_type.errors.full_messages }
      end
    end
  end

  # PUT /doc_types/1
  def update
    @doc_type = DocType.find(params[:id])

    respond_to do |format|
      if @doc_type.update_attributes(params[:doc_type])
        format.html { redirect_to @doc_type, notice: 'Doc type was successfully updated.' }
        format.xml { head :created, location: doc_type_path(@doc_type) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :unprocessable_entity, xml: @doc_type.errors.full_messages }
      end
    end
  end

  # DELETE /doc_types/1
  def destroy
    @doc_type = DocType.find(params[:id])
    @doc_type.destroy

    respond_to do |format|
      if @doc_type.destroy
        format.html { redirect_to doc_types_url }
        format.any(:xml, :js) { head :ok }
      else
        format.html { redirect_to doc_types_url }
        format.xml { render status: :conflict }
        format.js { render status: :conflict, text: "There are documents referencing this document type." }
      end
    end
  end
end

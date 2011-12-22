class DocTypesController < ApplicationController
  # GET /doc_types
  def index
    @doc_types = DocType.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /doc_types/1
  def show
    @doc_type = DocType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /doc_types/new
  def new
    @doc_type = DocType.new

    respond_to do |format|
      format.html # new.html.erb
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
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /doc_types/1
  def update
    @doc_type = DocType.find(params[:id])

    respond_to do |format|
      if @doc_type.update_attributes(params[:doc_type])
        format.html { redirect_to @doc_type, notice: 'Doc type was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /doc_types/1
  def destroy
    @doc_type = DocType.find(params[:id])
    @doc_type.destroy

    respond_to do |format|
      format.html { redirect_to doc_types_url }
    end
  end
end

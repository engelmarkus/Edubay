class TermsController < ApplicationController
  # GET /terms
  def index
    @terms = Term.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /terms/1
  def show
    @term = Term.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /terms/new
  def new
    @term = Term.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /terms/1/edit
  def edit
    @term = Term.find(params[:id])
  end

  # POST /terms
  def create
    @term = Term.new(params[:term])

    respond_to do |format|
      if @term.save
        format.html { redirect_to @term, notice: 'Term was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /terms/1
  def update
    @term = Term.find(params[:id])

    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to @term, notice: 'Term was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /terms/1
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to terms_url }
    end
  end
end

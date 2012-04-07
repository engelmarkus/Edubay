class TermsController < ApplicationController
  before_filter :redirect_if_not_admin, except: ['index', 'show']
  
  # GET /terms
  def index
    @terms = Term.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @terms }
    end
  end

  # GET /terms/1
  def show
    @term = Term.find(params[:id])
    
    @courses = @term.courses.find(:all)
    #@documents_by_date = @documents.group_by { |doc| doc.course_date }
    

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @term }
    end
  end

  # GET /terms/new
  def new
    @term = Term.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml: @term }
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
        format.xml { head :created, location: term_path(@term) }
      else
        format.html { render action: "new" }
        format.xml { render status: :unprocessable_entity, xml: @term.errors.full_messages }
      end
    end
  end

  # PUT /terms/1
  def update
    @term = Term.find(params[:id])

    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to @term, notice: 'Term was successfully updated.' }
        format.xml { head :created, location: term_path(@term) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :unprocessable_entity, xml: @term.errors.full_messages }
      end
    end
  end

  # DELETE /terms/1
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      if @term.destroy
        format.html { redirect_to terms_url }
        format.any(:xml, :js) { head :ok }
      else
        format.html { redirect_to terms_url }
        format.xml { render status: :conflict }
        format.js { render status: :conflict, text: "There are courses referencing this term." }
      end
    end
  end
end

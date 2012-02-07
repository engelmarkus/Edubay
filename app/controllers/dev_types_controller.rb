class DevTypesController < ApplicationController
  # GET /dev_types
  def index
    @dev_types = DevType.all
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @dev_types }
    end
  end

  # GET /dev_types/1
  def show
    @dev_type = DevType.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @dev_type }    
    end
  end

  # GET /dev_types/new
  def new
    @dev_type = DevType.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml: @dev_type }    
    end
  end

  # GET /dev_types/1/edit
  def edit
    @dev_type = DevType.find(params[:id])
  end

  # POST /dev_types
  def create
    @dev_type = DevType.new(params[:dev_type])
  
    respond_to do |format|
      if @dev_type.save
        format.html { redirect_to @dev_type, notice: 'Dev type was successfully created.' }
        format.xml { head :created, location: dev_type_path(@dev_type) }
      else
        format.html { render action: "new" }
        format.xml { render status: :unprocessable_entity, xml: @dev_type.errors.full_messages }
      end
    end
  end

  # PUT /dev_types/1
  def update
    @dev_type = DevType.find(params[:id])
  
    respond_to do |format|
      if @dev_type.update_attributes(params[:dev_type])
        format.html { redirect_to @dev_type, notice: 'Dev type was successfully updated.' }
        format.xml { head :created, location: dev_type_path(@dev_type) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :unprocessable_entity, xml: @dev_type.errors.full_messages }
      end
    end
  end

  # DELETE /dev_types/1
  def destroy
    @dev_type = DevType.find(params[:id])
  
    respond_to do |format|
      if @dev_type.destroy
        format.html { redirect_to dev_types_url }
        format.any(:xml, :js) { head :ok }
      else
        format.html { redirect_to dev_types_url }
        format.xml { render status: :conflict }
        format.js { render status: :conflict, text: "There are devices referencing this device type." }
      end
    end
  end
end

class DevTypesController < ApplicationController
  # GET /dev_types
  # GET /dev_types.json
  def index
    @dev_types = DevType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dev_types }
    end
  end

  # GET /dev_types/1
  # GET /dev_types/1.json
  def show
    @dev_type = DevType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dev_type }
    end
  end

  # GET /dev_types/new
  # GET /dev_types/new.json
  def new
    @dev_type = DevType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dev_type }
    end
  end

  # GET /dev_types/1/edit
  def edit
    @dev_type = DevType.find(params[:id])
  end

  # POST /dev_types
  # POST /dev_types.json
  def create
    @dev_type = DevType.new(params[:dev_type])

    respond_to do |format|
      if @dev_type.save
        format.html { redirect_to @dev_type, notice: 'Dev type was successfully created.' }
        format.json { render json: @dev_type, status: :created, location: @dev_type }
      else
        format.html { render action: "new" }
        format.json { render json: @dev_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dev_types/1
  # PUT /dev_types/1.json
  def update
    @dev_type = DevType.find(params[:id])

    respond_to do |format|
      if @dev_type.update_attributes(params[:dev_type])
        format.html { redirect_to @dev_type, notice: 'Dev type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dev_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dev_types/1
  # DELETE /dev_types/1.json
  def destroy
    @dev_type = DevType.find(params[:id])
    @dev_type.destroy

    respond_to do |format|
      format.html { redirect_to dev_types_url }
      format.json { head :no_content }
    end
  end
end

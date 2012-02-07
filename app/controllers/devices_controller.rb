class DevicesController < ApplicationController
  # GET /devices
  def index
    @devices = Device.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @devices }
    end
  end

  # GET /devices/1
  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @device }
    end
  end

  # GET /devices/new
  def new
    @device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml: @device }
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  def create
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.xml { head :created, location: device_path(@device) }
      else
        format.html { render action: "new" }
        format.xml { render status: :unprocessable_entity, xml: @device.errors.full_messages }
      end
    end
  end

  # PUT /devices/1
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.xml { head :created, location: device_path(@device) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :unprocessable_entity, xml: @device.errors.full_messages }
      end
    end
  end

  # DELETE /devices/1
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      if @device.destroy
        format.html { redirect_to devices_url }
        format.any(:xml, :js) { head :ok }
      else
        format.html { redirect_to devices_url }
        format.xml { render status: :conflict }
        format.js { render status: :conflict, text: "There are reservations referencing this device." }
      end
    end
  end
end

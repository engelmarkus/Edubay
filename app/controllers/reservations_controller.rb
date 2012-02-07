class ReservationsController < ApplicationController
  # GET /reservations
  def index
    @reservations = Reservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @reservations }
    end
  end

  # GET /reservations/1
  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @reservation }
    end
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(params[:reservation])

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.xml { head :created, location: reservation_path(@reservation) }
      else
        format.html { render action: "new" }
        format.xml { render status: :unprocessable_entity, xml: @reservation.errors.full_messages }
      end
    end
  end

  # PUT /reservations/1
  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.xml { head :created, location: reservation_path(@reservation) }
      else
        format.html { render action: "edit" }
        format.xml { render status: :unprocessable_entity, xml: @reservation.errors.full_messages }
      end
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      if @reservation.destroy
        format.html { redirect_to reservations_url }
        format.any(:xml, :js) { head :ok }
      else
        format.html { redirect_to reservations_url }
        format.xml { render status: :conflict }
        format.js { render status: :conflict, text: "Error while trying to delete reservation." }
      end
    end
  end
end

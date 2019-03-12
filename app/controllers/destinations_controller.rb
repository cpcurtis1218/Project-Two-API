# frozen_string_literal: true

class DestinationsController < ProtectedController
  before_action :set_destination, only: %i[show update destroy]

  # GET /destinations
  def index
    @destinations = current_user.destinations

    render json: @destinations
  end

  # GET /destinations/1
  def show
    render json: @destination
  end

  # POST /destinations
  def create
    @destination = current_user.destinations.new(destination_params)

    if @destination.save
      render json: @destination, status: :created, location: @destination
    else
      render json: @destination.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /destinations/1
  def update
    if @destination.update(destination_params)
      render json: @destination
    else
      render json: @destination.errors, status: :unprocessable_entity
    end
  end

  # DELETE /destinations/1
  def destroy
    @destination.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_destination
    @destination = current_user.destinations.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def destination_params
    params.require(:destination).permit(:location, :note, :contact)
  end
end

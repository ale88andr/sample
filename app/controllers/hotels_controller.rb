class HotelsController < ApplicationController
  def index
    @hotels = Hotel.chronology
  end

  def show
    @hotel = Hotel.find(params[:id])
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = current_user.hotels.new(params[:hotel])
    if @hotel.save
      redirect_to hotels_path, notice: "Hotel added"
    else
      flash[:error] = "Hotel not added" and render :new
    end
  end

end

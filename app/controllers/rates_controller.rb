class RatesController < ApplicationController
  def create
    @result = Rate.add_vote(current_user, params[:hotel_id], params[:rate])
    redirect_to hotel_path(params[:hotel_id]), notice: @result
  end
end
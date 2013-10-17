class CommentsController < ApplicationController
  def create
    @result = Comment.create_hotel_comment_by_user(current_user, params[:hotel_id], params[:comment])
    redirect_to hotel_path(params[:hotel_id]), notice: @result
  end
end
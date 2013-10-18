class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

    def record_not_found
      render 'public/404', status: 404
    end
end

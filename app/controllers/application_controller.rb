class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate
    authenticate_with_http_basic do |key|
      @current_user = User.find_by_token key
      render json: {error: {message: "not authorized"}} unless @current_user
    end
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: {error: "record not found"}
  end
end

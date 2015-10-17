class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate
    authenticate_with_http_basic do |key|
      @current_user = User.find_by_token key
      render json: {error: {message: "not authorized"}} unless @current_user
    end
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing

  def record_not_found
    render json: {error: "record not found"}
  end

  def params_missing
    render json: {error: 'params missing'}
  end
end

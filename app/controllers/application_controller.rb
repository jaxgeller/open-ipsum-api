class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate
    authenticate_with_http_basic do |key|
      @current_user = User.find_by_token key
    end

    render json: {error: {message: "not authorized"}}, status: 401 unless @current_user
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing

  def record_not_found
    render json: {error: "record not found"}, status: 401
  end

  def params_missing
    render json: {error: 'params missing'}, status: 400
  end
end

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate
    authenticate_with_http_basic do |key|
      @current_user = User.find_by_token key
    end

    render json: {error: 'not authorized'}, status: 401 unless @current_user
  end

  # Cant find record
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def record_not_found
    render json: {error: 'record not found'}, status: 400
  end

  # Missing required Params
  rescue_from ActionController::ParameterMissing, with: :params_missing
  def params_missing
    render json: {error: 'params missing'}, status: 400
  end

  # Cant find route
  def route_not_found
    render json: {error: 'route not found'}, status: 404
  end
end

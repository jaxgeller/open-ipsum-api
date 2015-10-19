class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate
    authenticate_with_http_basic do |key|
      @current_user = User.find_by_token key
    end

    render json: {error: {message: "not authorized"}}, status: 403 unless @current_user
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing
  rescue_from ActionController::RoutingError, :with => :error_render_method

  def record_not_found
    render json: {error: "record not found"}, status: 401
  end

  def params_missing
    render json: {error: 'params missing'}, status: 400
  end

  def error_render_method
    render json: {error: 'no found'}, status: 404
  end
end

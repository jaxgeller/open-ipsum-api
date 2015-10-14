class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  respond_to :json
end

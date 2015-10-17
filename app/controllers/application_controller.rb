class ApplicationController < ActionController::API

  def authenticate
    if request.headers['Authorization']
      user = User.find_by_token request.headers['Authorization'].split('Bearer ')
      render json: {error: "not authorized"} unless user
    else
      render json: {error: "not authorized"}
    end
  end
end

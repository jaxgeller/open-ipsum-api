class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      render json: {status: "success", token: user.token, username: user.username}
    else
      render json: {status: "error", errors: "Email or password is wrong"}
    end
  end

  def destroy
    user = @current_user
    user.generate_token

    if user.save
      render json: {status: "success"}
    else
      render json: {status: "error", errors: "something went wrong"}
    end
  end
end

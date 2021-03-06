class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      render json: { token: user.token, username: user.username, email: user.email }
    else
      render json: { status: 'error', errors: 'Email or password is wrong' }, status: 422
    end
  end

  def destroy
    user = @current_user
    user.generate_token

    if user.save
      render json: { status: 'success' }
    else
      render json: { status: 'error', errors: 'something went wrong' }, status: 422
    end
  end
end

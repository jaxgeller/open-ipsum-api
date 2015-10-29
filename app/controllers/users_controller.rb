class UsersController < ApplicationController
  before_action :authenticate, only: [:update, :destroy]

  def show
    user = User.find_by_username params[:id]
    if user
      render json: user
    else
      record_not_found
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { token: user.token, username: user.username }
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    user = @current_user
    if user.update(params.require(:user).permit(:password, :password_confirmation))
      render json: { status: 'updated' }, status: 200
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user = @current_user
    if user.destroy
      render json: { status: 'deleted' }, status: 200
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

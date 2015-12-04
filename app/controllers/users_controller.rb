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
    p = params.require(:user).permit(:email, :password, :password_confirmation, :current_password)

    if p[:current_password]
      if user.authenticate p[:current_password]
        p.delete(:current_password)
        if user.update(p)
          render json: { status: 'updated' }, status: 200
        else
          render json: {errors: user.errors}, status: :unprocessable_entity
        end
      else
        render json: {errors: ['Incorrect Password']}, status: 401
      end
    else
      p.delete(:password)
      p.delete(:password_confirmation)
      if user.update(p)
        render json: { status: 'updated' }, status: 200
      else
        render json: {errors: user.errors}, status: :unprocessable_entity
      end
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

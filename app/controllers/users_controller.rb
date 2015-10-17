class UsersController < ApplicationController
  before_action :authenticate, only: [:update, :destroy]

  def show
    user = User.find_by_username params[:id]
    render json: user
  end

  def create
    strong_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    user = User.new(strong_params)
    if user.save
      render json: {status: "success", token: user.token}
    else
      render json: {status: "error", errors: user.errors}
    end
  end

  def update
    user = @current_user
    if user.update(params.require(:user).permit(:username))
      head :no_content
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user = @current_user
    if user.destroy
      head :no_content
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end

class UsersController < ApplicationController
  def show
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
  end

  def destroy
  end
end

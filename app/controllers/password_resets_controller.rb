class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(email_params[:email])
    user.send_password_reset if user

    head :no_content
  end

  def update
    user = User.find_by_password_reset_token!(params[:id])

    if user.password_reset_sent_at < 2.hours.ago
      render json: { status: 'Token expired' }, status: :bad_request
    elsif user.update_attributes(pass_params)
      user.reset_password_reset
      head :no_content
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def email_params
    params.require(:user).permit(:email)
  end

  def pass_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

# app/controllers/api/v1/users/passwords_controller.rb
class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:user][:email])
    if user
      user.send_reset_password_instructions
      render json: { message: 'Reset password instructions sent.' }, status: :ok
    else
      render json: { error: 'Email not found' }, status: :not_found
    end
  end

  def update
    user = User.reset_password_by_token(password_reset_params)
    if user.errors.empty?
      render json: { message: 'Password has been reset successfully.' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:reset_password_token, :password, :password_confirmation)
  end
end

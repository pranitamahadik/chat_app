class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully.' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

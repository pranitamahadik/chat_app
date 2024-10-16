class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      token = user.generate_jwt
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    # Handle logout logic if necessary
    head :no_content
  end
end

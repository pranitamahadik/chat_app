class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      user.update(online: true)
      token = user.generate_jwt
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    user = User.find_by(email: params[:user][:email])

    if user
      user.update(online: false)

      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

end

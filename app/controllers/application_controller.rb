class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #include Devise::Controllers::Helpers
  #allow_browser versions: :modern

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      @current_user = User.find(decoded_token['id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'You need to sign in or sign up before continuing.' }, status: :unauthorized
    end
  end
end

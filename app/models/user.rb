class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_jwt
    JWT.encode({ id: self.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.devise_jwt_secret_key)
  end
end

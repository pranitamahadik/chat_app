class Api::V1::UsersController < ApplicationController
  
  def online_status
    users = User.select(:id, :online)
    render json: users.map { |user| { user_id: user.id, online: user.online } }
  end
end


class Api::V1::ChatRoomsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    def index
        @chat_rooms = ChatRoom.all
        render json: @chat_rooms
    end

    def create
        @chat_room = ChatRoom.new(chat_room_params)
        if @chat_room.save
            render json: @chat_room, status: :created
        else
            render json: @chat_room.errors, status: :unprocessable_entity
        end
    end

    private

    def chat_room_params
        params.require(:chat_room).permit(:name)
    end
end


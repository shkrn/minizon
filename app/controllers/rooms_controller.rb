class RoomsController < ApplicationController
    before_action :login_required
    def index
        myroom_id = current_user.entries.pluck(:room_id)
        @another_entries = Entry.where(room_id: myroom_id).where.not(user_id: current_user.id)

        if login?
            @current_entry = Entry.where(user_id: current_user.id)
            @another_entry = Entry.where(user_id: nil)
            @room = Room.new
            @entry = Entry.new
                @current_entry.each do |current|
                    @another_entry.each do |another|
                        if current.room_id == another.room_id
                            @is_room = true
                            @room_id = current.room_id
                        end
                    end
                end
        end


    end
    
    def show
        @room = Room.find(params[:id])
        @messages = @room.messages.all
        @message = Message.new
        @entries = @room.entries
        @another_entry = @entries.where.not(user_id: current_user.id).first
    end

    def create
        room = Room.create
        if room.save
            current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
            another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
            redirect_to room_path(room),notice:"ルームを作成しました"
        else
            redirect_back(fallback_location: root_path,notice: "ルームの作成に失敗しました")
        end
    end

    def destroy
        room = Room.find(params[:id])
        room.destroy
        redirect_to rooms_path, notice: "ルームを削除しました"
    end
end

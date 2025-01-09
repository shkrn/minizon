class Admin::RoomsController < Admin::Base
    before_action :login_required
    def index
        @rooms = Room.order("id")
        #myroom_id = current_user.entries.pluck(:room_id)
        #@another_entries = Entry.where(room_id: myroom_id).where.not(user_id: current_user.id)
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
            redirect_to admin_room_path(room),notice:"ルームを作成しました"
        else
            redirect_back(fallback_location: admin_root_path,notice: "ルームの作成に失敗しました")
        end
    end

    def destroy
        room = Room.find(params[:id])
        room.destroy
        redirect_to admin_rooms_path, notice: "ルームを削除しました"
    end
end

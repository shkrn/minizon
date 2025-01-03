class MessagesController < ApplicationController
    before_action :login_required

    def create
        @message = Message.new(message_params)
        @message.user_id = current_user.id
        if @message.save
          redirect_to room_path(@message.room)
        else
          redirect_back(fallback_location: root_path,notice: "メッセージ送信に失敗しました")
        end
    end
    
      private
        def message_params
          params.require(:message).permit(:room_id, :message)
        end
end

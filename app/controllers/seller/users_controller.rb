class Seller::UsersController < Seller::Base
    before_action :seller_login_required
    def show
        @user = User.find_by(id: params[:id])

        if login?
            @current_entry = Entry.where(user_id: current_user.id)
            @another_entry = Entry.where(user_id: @user.id)
            @room = Room.new
            @entry = Entry.new
            unless @user.id == current_user.id
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
    end

end

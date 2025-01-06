class UsersController < ApplicationController
    before_action :login_required, only: [:favorites]
    def index
    end

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

    def new

    end

    def edit

    end

    def create

    end

    def update
    
    end

    def destroy
        @user = User.find(params[:id])
        if @user.items.joins(:order_items)
            .where(order_items: { delivery: 'undelivered' })
            .exists?
            redirect_to admin_users_path, notice: "配送中の商品があるため削除できません"
        else
            redirect_to admin_users_path, notice: "ユーザーを削除しました"
        end
    end

    def favorites
        @favorite_users = current_user.favorite_users.order(created_at: :desc)
        @favorite_items = current_user.favorite_items.order(created_at: :desc)
    end

end

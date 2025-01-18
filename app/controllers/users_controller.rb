class UsersController < ApplicationController
    before_action :login_required, only: [:favorites]
    def index
        @users = User.where(status: "seller").order("id").page(params[:page]).per(30)
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
       
    end

    def favorites
        @favorite_users = current_user.favorite_users.order(created_at: :desc)
        @favorite_items = current_user.favorite_items.order(created_at: :desc)
    end

    def usersearch
        @sellers = User.where(status: "seller")
        @users = @sellers.where("business_name LIKE ?", "%#{params[:q]}%").page(params[:page]).per(30)
        render "index"
    end

    def search
        @users = User.search(params[:q]).page(params[:page]).per(30)
        render "index"
    end

end

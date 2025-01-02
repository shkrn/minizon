class UsersController < ApplicationController
    before_action :login_required, only: [:favorites]
    def index
    end

    def show
        @user = User.find(params[:id])
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

end

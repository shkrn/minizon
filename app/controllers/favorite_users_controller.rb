class FavoriteUsersController < ApplicationController
    before_action :login_required

    def index
        @favorite_users = current_user.favorite_users.order(created_at: :desc)
    end

    def create
        @user = User.find(params[:user_id])
        favorite = current_user.favorite_users.create(favorite_user: @user)
        if favorite.save
            redirect_back(fallback_location: root_path, notice: "お気に入りに登録しました")
        else
            redirect_back(fallback_location: root_path, alert: "お気に入りの登録に失敗しました")
        end
    end
    
    def destroy
        @favorite = current_user.favorite_users.find_by!(favorite_user_id: params[:id])
        @favorite.destroy
        redirect_back fallback_location: root_path, notice: 'お気に入りを解除しました'
    end
end

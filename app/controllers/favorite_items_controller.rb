class FavoriteItemsController < ApplicationController
    before_action :login_required
    def index
        @favorite_items = current_user.favorite_items.order(created_at: :desc)
    end
    def create
        # current_userはDeviseなどで取得している前提
        @item = Item.find(params[:item_id])
        current_user.favorite_items.create(item: @item)
        redirect_back(fallback_location: root_path, notice: "お気に入りに登録しました")
      end
    
      def destroy
        @favorite_item = current_user.favorite_items.find(params[:id])
        @favorite_item.destroy
        redirect_back(fallback_location: root_path, notice: "お気に入りから削除しました")
      end
end

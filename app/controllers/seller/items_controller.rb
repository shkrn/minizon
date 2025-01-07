##############################
############Seller############
##############################
class Seller::ItemsController < Seller::Base

    def index
        @items = Item.where(user_id: current_user.id).order(id: :asc)
    end
    def show
        @item = Item.find(params[:id])
            render "show"
    end
    def new
        @item = Item.new()

    end
    def edit
        @item = Item.find(params[:id])
    end
    def create
        @item = Item.new(params[:item])
        @item.user_id = current_user.id
        if @item.save
            redirect_to [:seller,@item], notice: "情報を登録しました。商品IDは#{@item.id}です。"
        else
            render "new"
        end
    end
    def update
        @item = Item.find(params[:id])
        @item.assign_attributes(params[:item])
        if @item.save
            redirect_to [:seller,@item], notice: "情報を更新しました。"
        else
            render "edit"
        end
    end
    def destroy
        @item = Item.find(params[:id])
        
        if OrderItem.where(item_id: @item.id).exists?
            redirect_to seller_items_path, notice: "購入されている商品は削除できません。"
        elsif @item.destroy
            redirect_to [:seller,@item], notice: "情報を削除しました。"
        else
            redirect_to [:seller,@item], alert: "情報の削除に失敗しました。"
        end
    end
    def search
        @items = Item.search(params[:q])
        render "index"
    end
end

##############################
############  Admin  ############
##############################
class Admin::ItemsController < Admin::Base
    def index
        if params[:user_id].present?
            @user = User.find(params[:user_id])
            @items = @user.items.order(id: :asc).page(params[:page]).per(30)
        else
            @items = Item.order(id: :asc).page(params[:page]).per(30)
        end
    end
    def show
        @item = Item.find(params[:id])
            render "show"
    end
    def edit
        @item = Item.find(params[:id])
    end
    def update
        @item = Item.find(params[:id])
        @item.assign_attributes(params[:item])
        if @item.save
            redirect_to [:admin,@item], notice: "情報を更新しました。"
        else
            render "edit"
        end
    end
    def destroy
        @item = Item.find(params[:id])
        
        if OrderItem.where(item_id: @item.id).exists?
            redirect_to admin_items_path, notice: "購入されている商品は削除できません。"
        elsif @item.destroy
            redirect_to [:admin,@item], notice: "情報を削除しました。"
        else
            redirect_to [:admin,@item], alert: "情報の削除に失敗しました。"
        end
    end
    def search
        @items = Item.search(params[:q]).page(params[:page]).per(30)
        render "index"
    end
end

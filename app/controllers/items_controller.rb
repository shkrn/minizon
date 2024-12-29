class ItemsController < ApplicationController
        before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
    def index
        @items = Item.order("id")
    end
    def show
        @item = Item.find(params[:id])
        if current_user&.seller?
            render "show_seller"
        else
            render "show_buyer"
        end
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
            redirect_to @item, notice: "情報を登録しました。"
        else
            render "new"
        end
    end
    def update
        @item = Item.find(params[:id])
        @item.assign_attributes(params[:item])
        if @item.save
            redirect_to [@item], notice: "情報を更新しました。"
        else
            render "edit"
        end
    end
    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to :items, notice: "情報を削除しました。"
    end
    def search
        @items = Item.search(params[:q])
        render "index"
    end
end

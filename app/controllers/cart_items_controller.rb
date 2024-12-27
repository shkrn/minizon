class CartItemsController < ApplicationController
    
    def index
        @cart_items = CartItem.where(cart_id: current_cart.id)
    end

    def show

    end

    def new

    end

    def edit

    end

    def create
        @cart_item = current_cart.add_item(params[:item_id], params[:quantity].to_i)
        if @cart_item.persisted?
        redirect_to item_path(params[:item_id]), notice: 'アイテムをカートに追加しました。'
        else
        redirect_to item_path(params[:item_id]), notice: 'アイテムの追加に失敗しました。'
        end
    end

    def update
    
    end

    def destroy

    end
end

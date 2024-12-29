class CartItemsController < ApplicationController
    
    def index
        
    end

    def show

    end

    def new

    end

    def edit

    end

    def create
        #カートにアイテムを追加する
        ci = current_cart.cart_items.find_by(item_id: params[:item_id])
        
        if ci 
            ci.quantity += params[:quantity].to_i
            noticemsg = 'アイテムの数量を更新しました。'
            if ci.save # saveが成功した場合のみメッセージを設定
                noticemsg = 'アイテムの数量を更新しました。'
            else
                noticemsg = 'アイテムの数量更新に失敗しました。'
            end
        else
            ci = current_cart.cart_items.create(
                item_id: params[:item_id], 
                quantity: params[:quantity],
                price: Item.find(params[:item_id]).price
                )
            if ci.persisted?
                noticemsg = 'アイテムをカートに追加しました。'
            else
                noticemsg = 'アイテムの追加に失敗しました。'
            end
        end
        
        
        redirect_to cart_path, notice: noticemsg
    end

    def update
        @cart_item = CartItem.find(params[:id])
        if @cart_item.update(quantity: params[:quantity])
            redirect_to cart_path, notice: 'カートの商品数量を更新しました。'
        else
            redirect_to cart_path, alert: 'カートの商品数量の更新に失敗しました。'
        end
    end

    def destroy
        #カートからアイテムを削除する
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_path, notice: 'カートからアイテムを削除しました。'
    end

end

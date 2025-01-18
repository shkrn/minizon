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
        puts "-------------------------------"
        puts current_user

        if current_user&.admin?
            redirect_to root_path, notice: "管理者ユーザーはカートを利用できません" and return
        end
        item = Item.find(params[:item_id])
        if params[:quantity].to_i <= item.stock
            #カートにアイテムを追加する
            ci = current_cart.cart_items.find_by(item_id: params[:item_id])
                #数量更新
                if ci
                    if ci.quantity + params[:quantity].to_i <= item.stock
                        ci.quantity += params[:quantity].to_i
                        noticemsg = 'アイテムの数量を更新しました。' if ci.save
                    else
                        noticemsg = '数量の更新に失敗しました。在庫が不足している可能性があります。'
                    end
                        noticemsg = 'アイテムの数量更新に失敗しました。' unless ci.save
                #新規追加
                else
                    if current_user.nil? || current_user.buyer?
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
                    else 
                        noticemsg = '購入者ユーザー以外はカートにアイテムを追加できません。'
                    end
                end
        else
            noticemsg = '在庫が足りません。'
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
        @cart_item = CartItem&.find(params[:id])
        @cart_item.destroy
        redirect_to cart_path, notice: 'カートからアイテムを削除しました。'
    end

end

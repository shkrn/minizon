class Seller::OrderItemsController < Seller::Base
    def show
        @order_item = OrderItem.find(params[:id])
    end
    def edit
        @order_item = OrderItem.find(params[:id])
    end
    def update
        @order_item = OrderItem.find(params[:id])
        @order_item.assign_attributes(params[:order_item])

        if @order_item.delivery == "returned"
        #在庫に返品数を追加（仮)
        @order_item.item.update(stock: @order_item.item.stock + @order_item.quantity)
        end
        
        if @order_item.save
          redirect_to [:seller, @order_item], notice: "情報を更新しました。"
        else
          render "edit"
        end
    end
end

class Admin::OrderItemsController < Admin::Base
    def show
        @order_item = OrderItem.find(params[:id])
    end
    def edit
        @order_item = OrderItem.find(params[:id])
    end
    def update
        @order_item = OrderItem.find(params[:id])
        @order_item.assign_attributes(params[:order_item])
        if @order_item.save
          redirect_to [:admin, @order_item], notice: "情報を更新しました。"
        else
          render "edit"
        end
    end
end

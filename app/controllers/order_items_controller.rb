class OrderItemsController < ApplicationController
    def show
        @order_item = OrderItem.find(params[:id])
    end
    def update
        @order_item = OrderItem.find(params[:id])
        if @order_item.update(order_item_params)
            redirect_to orders_path, notice: "配送状況を更新しました"
        else
            redirect_to orders_path, notice: "配送状況を更新に失敗しました"
        end
    end
    def destroy
        # @order_item = OrderItem.find(params[:id])
        # @order = @order_item.order
        # @order_item.destroy
        # if @order.order_items.empty?
        #     @order.destroy
        # else
        #     #仮実装
        #     @order.update(total_price: @order.total_price - (@order_item.price*@order_item.quantity))
        # end
        # @order_item.item.update(stock: @order_item.item.stock + @order_item.quantity)
        # redirect_to orders_path, notice: "商品をキャンセルしました"
        
    end

    def cancel
        @order_item = OrderItem.find(params[:id])
        @order = @order_item.order

        if @order_item.delivery == "undelivered"
            @order.update(total_price: @order.total_price - (@order_item.price*@order_item.quantity))
            @order_item.update(delivery: :canceled)
            @order_item.item.update(stock: @order_item.item.stock + @order_item.quantity)
            redirect_to orders_path, notice: "商品をキャンセルしました"
        elsif @order_item.delivery == "shipped"
            redirect_to orders_path, notice: "配送中の商品のため、キャンセルできません"
        else
            redirect_to orders_path, notice: "処理に失敗しました"
        end
    end
    def return
        @order_item = OrderItem.find(params[:id])
        @order_item.update(delivery: :returning)
        redirect_to orders_path, notice: "返品処理をしました"
    end
end

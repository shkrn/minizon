class Admin::OrdersController < Admin::Base

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      order_ids = @user.orders.pluck(:id)
      @order_items = OrderItem.where(order_id: order_ids).order(created_at: :desc)
    else
      @order_items = OrderItem.order(id: :asc)
    end
  end

  

  
end

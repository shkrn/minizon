class Admin::OrdersController < Admin::Base

  def index
    @order_items = OrderItem.order(id: :asc)
  end

  

  
end

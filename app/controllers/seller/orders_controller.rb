class Seller::OrdersController < Seller::Base

  def index
    @order_items = OrderItem.where(item_id: current_user.items.ids).order(id: :asc)
  end

  

  
end

class OrdersController < ApplicationController
  layout false, only: [:confirm]
  before_action :login_required
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    
    
  end

  def new

  end

  def create
    @order = Order.new(params[:order])
    @order.user_id = current_user.id
    @order.quantity = current_cart.cart_items.sum(:quantity)
    @order.total_price = current_cart.price
    if @order.save
      current_cart.cart_items.each do |item|
        @order.order_items.create!(
          item_id: item.item_id,
          quantity: item.quantity,
          price: item.price,
          delivery: 0
        )
        item.destroy
      end
      current_cart.update!(price: 0)
      redirect_to :orders, notice: "注文を登録しました。注文番号は#{@order.id}です。"
    else
      render "confirm"
    end
  end

  def confirm
    @cart_items = CartItem.where(cart_id: current_cart.id)
    if @cart_items.count == 0
      redirect_to :cart, notice: "カートに商品がありません。"
    else
      @order = Order.new(params[:order])
      @order.user_id = current_user.id
      render "confirm" unless @order.valid?
    end
  end
end

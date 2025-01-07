class OrdersController < ApplicationController
  layout false, only: [:confirm]
  before_action :login_required ,except: [:confirm]
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    
    
  end

  def new

  end

  def create
    if current_cart.cart_items.count != 0
      @order = Order.new(params[:order])
      @order.user_id = current_user.id
      @order.quantity = current_cart.cart_items.sum(:quantity)
      @order.total_price = current_cart.price
      if @order.save
        current_cart.cart_items.each do |ci|
          @order.order_items.create!(
            item_id: ci.item_id,
            quantity: ci.quantity,
            price: ci.price,
            delivery: 0
          )
          ci.destroy
          
          item = Item.find(ci.item_id)
          item.stock = item.stock - ci.quantity
          item.save!
        end
        current_cart.update!(price: 0)
        redirect_to :orders, notice: "注文を登録しました。注文番号は#{@order.id}です。"
      else
        render "confirm"
      end
    else
      redirect_to :cart, notice: "カートに商品がありません。"
    end
  end

  def confirm
    @cart_items = CartItem.where(cart_id: current_cart.id)
    if @cart_items.count == 0
      redirect_to :cart, notice: "カートに商品がありません。"
    elsif !login?
      redirect_to new_account_path(type: :buyer,from: :order_confirm) , notice: "購入には会員登録もしくはログインが必要です。"
    else
      @order = Order.new(params[:order])
      @order.user_id = current_user.id
      render "confirm" unless @order.valid?
    end
  end
end

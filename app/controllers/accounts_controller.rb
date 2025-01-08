class AccountsController < ApplicationController
  before_action :login_required, except: [:new,:create]
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(params[:account])
    if @user.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  def new
    @user = User.new
    if params[:from]=="order_confirm"
      #デバッグ用
      puts "order_confirmからの遷移"
    end
  end
  def create
    @user = User.new(params[:account])
    if current_cart.present?
      # @user.build_cart  # 新しいカートを作成
      # # 既存のカートアイテムを新しいカートに移動
      # current_cart.cart_items.each do |item|
      #   @user.cart.cart_items.build(
      #     item: item.item,
      #     quantity: item.quantity,
      #     price: item.price
      #   )
      # end
      @user.cart = current_cart
    end
    if @user.save
        session[:user_id] = @user.id
        
        redirect_to :root, notice: "会員登録が完了しました。"
    else
        render "new"
    end
  end

  def destroy
    @user = current_user
    if @user.can_destroy?
      current_cart.cart_items.destroy
      @user.destroy
      redirect_to :root, notice: "アカウントを削除しました。"
    else
      redirect_to :root, notice: "配送中の商品があるため削除できません。"
    end
  end
end

class AccountsController < ApplicationController
  before_action :login_required
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
    if params[:type] == 'seller'
      render 'new_seller'
    else
      render 'new_buyer'
    end
  end
  def create
    @user = User.new(params[:account])
    if @user.save
        session[:user_id] = @user.id      
        redirect_to :root, notice: "会員登録が完了しました。"
    else
        render "new"
    end
  end
end

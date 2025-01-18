class TopController < ApplicationController
  layout false, only: [:login]
  PER_PAGE = 20
  def index
    ##itemからコピー
        @items = Item.where(status: "available")

        if params[:category_id].present?
            @items = @items.where(category_id: params[:category_id])
        end
        if params[:user_id].present?
            @items = @items.where(user_id: params[:user_id])
        end
        if params[:min_price].present?
            @items = @items.where('price >= ?', params[:min_price])
        end
        if params[:max_price].present?
            @items = @items.where('price <= ?', params[:max_price])
        end

        @items = @items.order("id").page(params[:page]).per(PER_PAGE)
  end
  def login
    if admin?
      redirect_to admin_root_path
      puts "管理者としてログインしています"
    end
  end
  def bad_request
    raise ActionController::ParameterMissing,""
  end

  def forbidden
    raise Forbidden,""
  end

  def internal_server_error
    raise
  end
end

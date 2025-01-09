class ItemsController < ApplicationController
        before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
        PER_PAGE = 20
    def index

        @items = Item.order("id").page(params[:page]).per(PER_PAGE)

        if params[:category_id]
            @items = @items.where(category_id: params[:category_id]).order("id").page(params[:page]).per(PER_PAGE)
        end
        if params[:user_id]
            @items = @items.where(user_id: params[:user_id]).order("id").page(params[:page]).per(PER_PAGE)
        end
        if params[:min_price].present?
            @items = @items.where('price >= ?', params[:min_price]).order("id").page(params[:page]).per(PER_PAGE)
        end
        if params[:max_price].present?
            @items = @items.where('price <= ?', params[:max_price]).order("id").page(params[:page]).per(PER_PAGE)
        end
    end
    def show
        @item = Item.find(params[:id])
            render "show"
    end
    def search
        @items = Item.search(params[:q]).page(params[:page]).per(PER_PAGE)
        render "index"
    end
end

class ItemsController < ApplicationController
        before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
    def index
        @items = Item.order("id")
    end
    def show
        @item = Item.find(params[:id])
            render "show"
    end
    def search
        @items = Item.search(params[:q])
        render "index"
    end
end

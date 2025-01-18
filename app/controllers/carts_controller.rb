class CartsController < ApplicationController
    def index
    end

    def show
            if current_user&.admin?
              redirect_to root_path, notice: "管理者はカートにアクセスできません" and return
            elsif current_user&.seller?
              redirect_to root_path, notice: "購入者以外はアクセスできません" and return
            end
            @cart_items = CartItem.where(cart_id: current_cart.id)
    end

    def new

    end

    def edit

    end

    def create
        
    end

    def update
    
    end

    def destroy

    end

    def add

    end
end

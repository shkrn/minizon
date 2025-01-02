class CartsController < ApplicationController
    def index
    end

    def show
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

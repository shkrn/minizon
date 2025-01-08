class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :item

    after_save :update_cart_price
    after_destroy :update_cart_price

    validates :quantity, numericality: { only_integer: true, greater_than: 0 }


    def update_cart_price
        cart.update!(price: cart.cart_items.sum { |c| c.price * c.quantity })
        puts "カートの合計金額を更新しました。"
    end
end

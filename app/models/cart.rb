class Cart < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    belongs_to :user, optional: true
    def add_item(item_id, quantity = 1)
      current_item = cart_items.find_by(item_id: item_id)
      if current_item
        # 既存のアイテムがあれば数量を増やす
        current_item.quantity += quantity
      else
        # 新しいアイテムを追加
        current_item = cart_items.build(item_id: item_id, quantity: quantity,price: price)
      end
      current_item.save
      current_item
    end
end

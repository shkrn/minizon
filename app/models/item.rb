class Item < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :cart_items, dependent: :destroy
    has_one_attached :item_picture
    attribute :new_item_picture
    attribute :remove_item_picture

    before_save do
        if new_item_picture
        self.item_picture = new_item_picture
        end
    end
    class << self
        def search(query)
            rel = order("id")
            if query.present?
                rel = rel.where("name LIKE ?","%#{query}%")
            end
            rel
        end
    end
end

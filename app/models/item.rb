class Item < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :cart_items, dependent: :destroy
    has_many :order_items
    has_many :reviews, dependent: :destroy
    has_many :favorite_items, dependent: :destroy


    has_one_attached :item_picture
    attribute :new_item_picture
    attribute :remove_item_picture


    enum status: {
        available: 0,
        unavailable: 1
    }


    validates :name, presence: true, length: { maximum: 50 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 100000000 }
    validates :status, presence: true
    validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    before_save do
        if new_item_picture
        self.item_picture = new_item_picture
        end
    end
    class << self
        def search(query)
            rel = order("id")
            if query.present?
                rel = rel.where(
                    "name LIKE ? OR description LIKE ?",
                    "%#{query}%",
                    "%#{query}%"
                    )
            end
            rel
        end
    end
end

class Order < ApplicationRecord
    has_many :order_items, dependent: :destroy
    belongs_to :user
    validates :total_price, presence: true, numericality: { only_integer: true, greater_than: 0 }
end

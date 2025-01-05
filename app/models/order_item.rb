class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :item
    enum delivery: {
        undelivered: 0,
        shipped: 1,
        delivered: 2
        }
end

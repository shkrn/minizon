class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :item
    enum delivery: {
        undelivered: 0,
        shipped: 1,
        delivered: 2,
        returning: 91,
        returned: 92
        }

    def returnable?
        #配達済みかつ注文から30日以内の場合
        delivered? && created_at > 30.days.ago
    end
end

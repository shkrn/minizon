class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :item
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }
    enum delivery: {
        undelivered: 1,
        shipped: 2,
        delivered: 3,
        canceled: 4,
        returning: 5,
        returned: 6
        }

    def returnable?
        #配達済みかつ注文から30日以内の場合
        delivered? && created_at > 30.days.ago
    end
end

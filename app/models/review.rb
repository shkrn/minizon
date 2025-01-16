class Review < ApplicationRecord
    belongs_to :user
    belongs_to :item

    validates :rating, presence: true, numericality: { only_integer: true, greater_than: 1, less_than: 5 }
    validates :content, presence: true, length: { maximum: 200 }

    class << self
        def search(report, query)
          rel = order(created_at: :desc)
          
          if query.present?
            rel = rel.joins(:item).where(
              "items.name LIKE ? OR content LIKE ? OR rating = ?",
              "%#{query}%", "%#{query}%", query.to_i
            )
          end
          
          if report != "null"
            rel = rel.where(report: report)
          end
          
          rel
        end
    end
end

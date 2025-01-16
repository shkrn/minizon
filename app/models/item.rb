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
    validates :code, presence: true, length: { maximum: 30 }
    validates :description, presence: true, length: { maximum: 500 }
    validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100000000 }
    validates :status, presence: true
    validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 99 }

    validate :prevent_remove_without_new_image, on: :update

    private

    def prevent_remove_without_new_image
        # 更新時に remove_item_picture が指定され、かつ新しい画像がない場合はエラーにする
        if remove_item_picture && new_item_picture.blank?
        errors.add(:item_picture, "を削除できません。新しい画像をアップロードしてください。")
        end
    end

    validate if: :new_item_picture do
        if new_item_picture.respond_to?(:content_type)
            unless new_item_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
                errors.add(:new_item_picture, :invalid_image_type)
            end
        else
            errors.add(:new_item_picture, :invalid)
        end
    end

    before_save do
        if new_item_picture
            self.item_picture = new_item_picture
        elsif remove_item_picture
            self.item_picture.purge
        end
    end
    
    class << self
        def search(query)
            rel = order("items.id")
            if query.present?
                rel = rel.joins(:user).where(
                    "name LIKE ? OR description LIKE ? OR users.business_name LIKE ? OR users.id LIKE ?",
                    "%#{query}%",
                    "%#{query}%",
                    "%#{query}%",
                    "%#{query}%"
                    )
            end
            rel
        end
    end
end

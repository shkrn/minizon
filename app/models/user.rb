class User < ApplicationRecord
    has_secure_password
    enum status: { buyer: 0, seller: 1 }
    
    has_many :items, dependent: :destroy
    
    has_one :cart, dependent: :destroy
    has_many :orders, dependent: :destroy
    
    has_many :reviews, dependent: :destroy

    has_many :favorite_items, dependent: :destroy
    has_many :favorite_users, dependent: :destroy
    
    has_many :entries, dependent: :destroy
    has_many :messages, dependent: :destroy

    after_create :create_cart

    attr_accessor :current_password
    validates :password, presence: { if: :current_password }
    validates :full_name, presence: true, length: { maximum: 20 }
    validates :family_name, length: { maximum: 20 }
    validates :given_name, length: { maximum: 20 }
    validates :email, email: { allow_blank: true }

    def display_name
      if seller?
        business_name
      elsif buyer?
        full_name
      end
    end
    
  private def create_cart
    
    unless self.cart.present?
      Cart.create(user: self)
      puts "############カートを作成しました。###############"
    end
  end


  def can_destroy?
    !self.items.joins(:order_items)
    .where(order_items: { delivery: ['undelivered','returning'] })
    .exists?
  end

  def admin?
    false
  end

  class << self
    def search(query)
        rel = order("id")
        if query.present?
            rel = rel.where(
              "given_name LIKE ? OR full_name LIKE ? OR family_name LIKE ? OR business_name LIKE ? OR address LIKE ? OR phonenumber LIKE ? OR email LIKE ?", 
              "%#{query}%", 
              "%#{query}%", 
              "%#{query}%", 
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

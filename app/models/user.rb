class User < ApplicationRecord
    has_secure_password
    has_many :items, dependent: :destroy
    enum status: { buyer: 0, seller: 1 }
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

    def display_name
      if seller?
        business_name
      elsif buyer?
        full_name
      end
    end
    
  private

  def create_cart
    Cart.create(user: self)
  end

end

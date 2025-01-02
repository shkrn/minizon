class User < ApplicationRecord
    has_secure_password
    has_many :items, dependent: :destroy
    enum status: { buyer: 0, seller: 1 }
    has_one :cart, dependent: :destroy
    has_many :orders, dependent: :destroy

    after_create :create_cart

    attr_accessor :current_password
    validates :password, presence: { if: :current_password }

  private

  def create_cart
    Cart.create(user: self)
  end
end

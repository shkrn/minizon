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
    validates :password,  presence: { if: :current_password }, 
                          length: {minimum:8,maximum:16},
                          format: { with: /\A[a-zA-Z0-9\s\-_\.!]+\z/ },
                          on: :create

    validates :password,  presence: { if: :current_password }, 
                          length: {minimum:8,maximum:16},
                          format: { with: /\A[a-zA-Z0-9\s\-_\.!]+\z/ },
                          allow_blank: true,
                          on: :update
                          
    validates :full_name, length: { maximum: 20 }
    validates :family_name, presence:true ,length: { maximum: 15 }
    validates :given_name, presence:true ,length: { maximum: 15 }
    validates :business_name, presence:true ,length: { minimum: 2, maximum: 15 }, uniqueness: true
    validates :email, presence: true, uniqueness: true, email: { 
      mode: :strict
    }
    validates :address, presence:true ,length: { maximum: 50 }
    validates :phonenumber, length: { minimum: 8, maximum: 20 },
                            format: { with: /\A\d+(-?\d+)*\z/}


    def display_name
      if seller?
        business_name
      elsif buyer?
        full_name
      end
    end

    def admin?
      false
    end
    
    def can_destroy?
      !(
        self.items.joins(:order_items)
          .where(order_items: { delivery: ['undelivered','returning'] })
          .exists? ||
        self.items.exists?
      )
      
    end


    ########################################################################
    ###################       以下プライベートメソッド        ##################

    before_save :set_fullname

    private

    def set_fullname
      self.full_name = "#{family_name} #{given_name}"
    end

    private def create_cart
      
      unless self.cart.present?
        Cart.create(user: self)
        puts "############カートを作成しました。###############"
      end
    end


  

  class << self
    def search(status,query)
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
        if status != "null"
            rel = rel.where(status: status)
        end
        rel
    end
  end

end

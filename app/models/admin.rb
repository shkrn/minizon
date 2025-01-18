class Admin < ApplicationRecord
    has_secure_password



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
    validates :email, presence:true , uniqueness: true, email: { mode: :strict}
    validates :address, presence:true ,length: { maximum: 50 }
    validates :phonenumber, length: { minimum: 8, maximum: 20 },
                            format: { with: /\A0\d{1,4}-?\d{2,4}-?\d{4}\z/ }



    def seller?
      false
    end
    def buyer?
      false
    end

    def admin?
      true
    end

    ########################################################################
    ###################       以下プライベートメソッド        ##################

    before_save :set_fullname

    private

    def set_fullname
      self.full_name = "#{family_name} #{given_name}"
    end

    class << self
        def search(query)
            rel = order("id")
            if query.present?
                rel = rel.where(
                  "given_name LIKE ? OR full_name LIKE ? OR family_name LIKE ? OR address LIKE ? OR phonenumber LIKE ? OR email LIKE ?", 
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

class Admin < ApplicationRecord
    has_secure_password
    validates :email, presence: true
    has_many :messages, dependent: :destroy

    def seller?
      false
    end
    def buyer?
      false
    end

    def admin?
      true
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

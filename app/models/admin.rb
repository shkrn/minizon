class Admin < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true

    def seller?
      false
    end
    def buyer?
      false
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

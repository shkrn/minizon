class User < ApplicationRecord
    has_secure_password
    has_many :items, dependent: :destroy
    enum status: { buyer: 0, seller: 1 }
end

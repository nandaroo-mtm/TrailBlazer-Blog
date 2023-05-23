class User < ApplicationRecord
  has_secure_password validations: false
  has_many :posts, dependent: :destroy
  has_one :picture, as: :imageable, dependent: :destroy
end


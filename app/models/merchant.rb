class Merchant < ApplicationRecord

  validates :name, :address, :password, presence: true

  validates :email, presence: true, uniqueness: true

  has_secure_password

end

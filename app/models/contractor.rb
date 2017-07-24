class Contractor < ApplicationRecord
  validates :name, :password, :status, presence: true

  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_many :orders
end

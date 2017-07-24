class Contractor < ApplicationRecord
  validates :name, :email, :password, :status, presence: true

  has_many :orders
end

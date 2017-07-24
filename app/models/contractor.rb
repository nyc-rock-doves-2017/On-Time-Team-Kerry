class Contractor < ApplicationRecord
  has_many :orders
  has_secure_password
  validates :name, :email, :password, :status, presence: true
  validate :unique_email

  def unique_email
     merchant = Merchant.find_by(email: email)
     if merchant
       errors.add(:email, "Account already exists as merchant account")
     end
   end
end

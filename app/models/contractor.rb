class Contractor < ApplicationRecord
  has_many :orders
  
  has_secure_password
  
  validates :name, :password, :status, presence: true
  validates :email, presence: true, uniqueness: true
  validate :unique_email
  
  def unique_email
     merchant = Merchant.find_by(email: email)
     if merchant
       errors.add(:email, "Account already exists as merchant account")
     end
   end
end

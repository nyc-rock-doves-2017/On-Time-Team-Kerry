class Merchant < ApplicationRecord
  has_many :orders
  has_secure_password
  validates :name, :address, :password, presence: true
  validates :email, presence: true, uniqueness: true
  validate :unique_email

  def unique_email
     contractor = Contractor.find_by(email: email)
     if contractor
       errors.add(:email, "Account already exists as contractor account")
     end
   end


end

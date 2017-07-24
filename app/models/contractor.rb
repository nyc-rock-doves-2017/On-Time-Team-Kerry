class Contractor < ApplicationRecord
  validates :name, :email, :password, :status, presence: true

  has_many :orders

  def up
    change_column :contractors, :status, :boolean, default: true
  end
end

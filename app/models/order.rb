class Order < ApplicationRecord
  include OrdersHelper

  belongs_to :merchant
  belongs_to :contractor
end

module MerchantsHelper

  def average_claim_to_pick_up_time
    total_diff = 0
    num_of_orders = @merchant.orders.length
    @merchant.orders.each do |order|
      diff = order.pick_up_time - order.claim_time
      total_diff += diff
    end
    total_diff / num_of_orders
  end

  def average_pick_up_to_delivery_time
    total_diff = 0
    num_of_orders = @merchant.orders.length
    @merchant.orders.each do |order|
      diff = order.delivery_time - order.pick_up_time
      total_diff += diff
    end
    total_diff / num_of_orders
  end

  def average_claim_to_delivery_time
    total_diff = 0
    num_of_orders = @merchant.orders.length
    @merchant.orders.each do |order|
      diff = order.delivery_time - order.claim_time
      total_diff += diff
    end
    total_diff / num_of_orders
  end

end

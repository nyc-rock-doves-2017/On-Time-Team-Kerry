module MerchantsHelper

  def average_claim_to_pick_up_time
    total_diff = 0
    com_orders = @merchant.orders.select { |o| o.delivery_time != nil }
    if com_orders.length != 0
      com_orders.each do |order|
        diff = order.pick_up_time - order.claim_time
        total_diff += diff
      end
      average_diff = total_diff / com_orders.length
      (average_diff/60).floor
    end
  end

  def average_pick_up_to_delivery_time
    total_diff = 0
    com_orders = @merchant.orders.select { |o| o.delivery_time != nil }
    if com_orders.length != 0
      com_orders.each do |order|
          diff = order.delivery_time - order.pick_up_time
          total_diff += diff
        end
        average_diff = total_diff / com_orders.length
        (average_diff/60).floor
      end
  end

  def average_claim_to_delivery_time
    total_diff = 0
    com_orders = @merchant.orders.select { |o| o.delivery_time != nil }
    if com_orders.length != 0
      com_orders.each do |order|
          diff = order.delivery_time - order.claim_time
          total_diff += diff
        end
        average_diff = total_diff / com_orders.length
        (average_diff/60).floor
      end
  end
end

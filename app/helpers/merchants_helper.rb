module MerchantsHelper

  def average_times_by_contractor
    hash = {}
    Contractor.all.each do |con|
        hash[con.name] = con.orders.select { |o| o.merchant == @merchant }
    end
    hash.delete_if { |k, v| v.empty? }
    other_hash = {}
    hash.each do |k,v|
      total_diff = 0
      v.each do |order|
        diff = order.delivery_time - order.claim_time
        total_diff += diff
      end
      average_diff = total_diff / v.length
      avg = (average_diff/60).floor
      other_hash[k] = avg
    end
    return other_hash
    end

    def nice_list
      nice_list_hash = average_times_by_contractor.sort_by { |k,v| v }.to_h
      array = []
      nice_list_hash.each do |k,v|
        if v <= 20
          array << "#{k} averages #{v} minutes per delivery!"
        end
      end
      array
    end

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
      else
        "---"
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
    else
      "---"
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
    else
      "---"
    end
  end
end

module MerchantsHelper

  def average_times_by_contractor
    eligible_orders = @merchant.orders.select { |o| o.delivery_time }
    eligible_contractors_ids = eligible_orders.map { |o| o.contractor_id }
    eligible_contractors_ids = eligible_contractors_ids.uniq
    contractor_score_pairs = {}
      eligible_contractors_ids.each do |c_id|
        name = Contractor.find_by(id: c_id).name
        select_orders = eligible_orders.select { |order| order.contractor_id == c_id }
        num_of_orders = select_orders.length
        delivery_time_sum = 0
        select_orders.each do |order|
          time = order.delivery_time - order.claim_time
          time = time/60
          delivery_time_sum += time
        end
        score = delivery_time_sum / num_of_orders
        score = score.floor
        contractor_score_pairs[name] = score
      end
      top_performer_pairs = contractor_score_pairs.select { |name, score| score <= 20 }
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

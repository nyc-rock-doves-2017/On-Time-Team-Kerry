class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :contractor

  def claim_to_pick_up_time
    if self.pick_up_time && self.claim_time
      diff = self.pick_up_time - self.claim_time
      (diff/60).floor
    else
      "---"
    end
  end

  def pick_up_to_delivery_time
    if self.delivery_time  && self.pick_up_time
      diff = self.delivery_time - self.pick_up_time
      (diff/60).floor
    else
      "---"
    end
  end

  def claim_to_delivery_time
    if self.delivery_time && self.claim_time
      diff = self.delivery_time - self.claim_time
      (diff/60).floor
    else
      "---"
    end

  end
end

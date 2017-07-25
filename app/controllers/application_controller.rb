class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:type] == 'merchant'
      current_user||=Merchant.find_by(id: session[:user_id])
    elsif session[:type] == 'contractor'
      current_user||=Contractor.find_by(id: session[:user_id])
    else
      false
    end
  end

  def logged_in?
    !!current_user
  end

  def average_delivery_time
    total_diff = 0
    current_user.orders.each do |order|
      diff = order.delivery_time - order.claim_time
      total_diff += diff
    end
    average_diff = total_diff / current_user.orders.length
    return (average_diff/60).floor
  end

  def in_good_standing?
    if current_user.orders.length > 5 && average_delivery_time >= 25
      false
    else
      true
    end
  end

  helper_method :current_user
  helper_method :logged_in?
  helper_method :in_good_standing?
end

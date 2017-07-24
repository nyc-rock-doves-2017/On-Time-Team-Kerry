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

  helper_method :current_user
  helper_method :logged_in?
end

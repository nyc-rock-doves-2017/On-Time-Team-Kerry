class SessionsController < ApplicationController

  def home
    render layout: false
  end

  def new
  end

  def create
    @merchant = Merchant.find_by(email: params[:email])
    @contractor = Contrator.find_by(email: params[:email])
      if @merchant
        if @merchant.authenticate(params[:password])
          session[:user_id] = @merchant.id
          session[:type] = "merchant"
          redirect_to merchant_path(@merchant)
        else
          @errors = ["Incorrect email or password"]
          render status: 403, action: :new
        end
      elsif @contractor
        if @contractor.authenticate(params[:password])
          session[:user_id] = @contractor.id
          session[:type] = "contractor"
          redirect_to '/open_orders'
        else
          @errors = ["Incorrect email or password"]
          render status: 403, action: :new
        end
      else
        @errors = ["Input email and password"]
        render status: 422, action: :new
      end
  end

  def destroy
    session.destroy
    redirect_to root
  end

  def newsignup
    
  end

  def createsignup
  end

  def newregisration
  end

  def createregisration
  end



end

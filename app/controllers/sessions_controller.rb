class SessionsController < ApplicationController

  def home
    render layout: false
  end

  def new
    render layout: false
  end

  def create
    @merchant = Merchant.find_by(email: params[:email])
    @contractor = Contractor.find_by(email: params[:email])
      if @merchant
        if @merchant.authenticate(params[:password])
          session[:user_id] = @merchant.id
          session[:type] = "merchant"
          redirect_to merchant_path(@merchant)
        else
          @errors = ["Incorrect email or password"]
          render status: 403, action: :new, layout: false
        end
      elsif @contractor
        if @contractor.authenticate(params[:password])
          session[:user_id] = @contractor.id
          session[:type] = "contractor"
          open_orders = @contractor.orders.select { |o| o.delivery_time == nil }
          if open_orders.length != 0
            @order = open_orders[0]
            redirect_to "/merchants/#{@order.merchant_id}/orders/#{@order.id}"
          else
            redirect_to open_orders_path
          end
        else
          @errors = ["Incorrect email or password"]
          render status: 403, action: :new, layout: false
        end
      else
        @errors = ["Account not found. Input email and password."]
        render status: 422, action: :new, layout: false
      end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  def newsignup
    render layout: false
  end

  def createsignup
    session[:type] = params[:type]
    render action: :newregistration, layout: false
  end

  def newregistration
    render layout: false
    if session[:type] == "merchant"
      @merchant = Merchant.new
    else
      @contractor = Contractor.new
    end
  end

  def createregistration
    if session[:type] == "merchant"
      @merchant = Merchant.new(merchant_params)
      if @merchant.save
        session[:user_id] = @merchant.id
        redirect_to merchant_path(@merchant)
      else
        @errors = @merchant.errors.full_messages
        render status: 422, action: :newregistration, layout: false
      end
    else
      @contractor = Contractor.new(contractor_params)
      if @contractor.save
        session[:user_id] = @contractor.id
        redirect_to open_orders_path
      else
        @errors = @contractor.errors.full_messages
        render status: 422, action: :newregistration, layout: false
      end
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :address, :email, :password)
  end

  def contractor_params
    params.require(:contractor).permit(:name, :email, :password, :status)
  end

end

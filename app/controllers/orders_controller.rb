class OrdersController < ApplicationController

  def index
    @open_orders = Order.all.select { |o| o.claim_time == nil }
  end

  def new
    @merchant = Merchant.find_by(id: params[:merchant_id])
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to "/merchants/#{@order.merchant_id}/orders"
    else
      @errors = @order.errors.full_messages
      render status: 422, action: :new
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def update
    @order = Order.find_by(id: params[:id])
    @order.assign_attributes(update_order_params)
    if @order.save
      redirect_to "/merchants/#{@order.merchant_id}/orders/#{@order.id}"
    else
      @errors = @order.errors.full_messages
      render status: 422, action: :show
    end
  end

  private
    def order_params
      params.require(:orders).permit(:merchant_id, :destination, :contractor_id)
    end

    def update_order_params
      params.require(:orders).permit(:contractor_id, :claim_time, :pick_up_time, :delivery_time)
    end
end

class MerchantsController < ApplicationController

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to @merchant
    else
      @errors = @merchant.errors.full_messages
      render 'new'
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  private
    def merchant_params
      params.require(:merchant).permit(:name, :address, :email, :password)
    end

end

class ContractorsController < ApplicationController

  def new
    @contractor = Contractor.new
  end

  def create
    @contractor = Contractor.new(merchant_params)
    if @contractor.save
      redirect_to @contractor
    else
      @errors = @contractor.errors.full_messages
      render 'new'
    end
  end

  def show
    @contractor = Contrator.find(params[:id])
  end

  private
    def contractor_params
      params.require(:contractor).permit(:name, :email, :password, :status)
    end

end

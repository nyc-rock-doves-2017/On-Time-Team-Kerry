class ContractorsController < ApplicationController

  def index
  end

  def new
    @contractor = Contractor.new
  end

  def create
    @contractor = Contractor.new(contractor_params)
    if @contractor.save
      redirect_to open_orders_path
    else
      @errors = @contractor.errors.full_messages
      render 'new'
    end
  end

  def show
    @contractor = Contractor.find_by(id: params[:id])
  end

  private
    def contractor_params
      params.require(:contractor).permit(:name, :email, :password, :status)
    end
end

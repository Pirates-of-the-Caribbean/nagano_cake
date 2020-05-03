class Admin::CustomersController < Admin::Base

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end
end

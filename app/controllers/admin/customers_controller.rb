class Admin::CustomersController < Admin::Base

  def index
    @customers = Customer.all
  end
end

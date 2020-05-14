class Admin::CustomersController < Admin::Base

  def index
    if params[:validness]
      @customers = Customer.where(validness: params[:validness]).all.page(params[:page])
    else
      @customers = Customer.all.page(params[:page])
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode,:address, :telephone_number, :email, :validness)
    end
end

class Public::ShippingAddressesController < Public::Base
	def create
		shipping_address = current_customer.shipping_addresses.new(shipping_address_params)
		shipping_address.customer_id = current_customer.id
		shipping_address.save
		redirect_to shipping_addresses_path
	end

	def index
		@shipping_address = current_customer.shipping_addresses.new
		@shipping_addresses = current_customer.shipping_addresses.all
	end

	def edit
		@shipping_address = ShippingAddress.find(params[:id])
	end

	def update
		shipping_address = ShippingAddress.find(params[:id])
		if shipping_address.update(shipping_address_params)
			redirect_to shipping_addresses_path
		else
			@shipping_address = current_customer.shipping_addresses.new
			@shipping_addresses = current_customer.shipping_addresses.all
			flash[:error] = "エラーです"
			render 'index'
		end
	end

	def destroy
		shipping_address = ShippingAddress.find(params[:id])
		shipping_address.destroy
		redirect_to shipping_addresses_path
	end

	private
	def shipping_address_params
		params.require(:shipping_address).permit( :postcode, :address, :name)
	end
end

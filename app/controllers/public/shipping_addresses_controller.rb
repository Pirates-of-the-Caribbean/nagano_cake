class Public::ShippingAddressesController < Public::Base
	# 直打ち禁止、ログインユーザー以外の配送先を見れないようにする
	before_action :correct_customer, only: [:edit, :update]
	def create
		@shipping_address = current_customer.shipping_addresses.new(shipping_address_params)
		@shipping_address.customer_id = current_customer.id
		if @shipping_address.save
			redirect_to shipping_addresses_path
		else
			@shipping_addresses = current_customer.shipping_addresses.all
			render 'index'
		end
	end

	def index
		@shipping_address = current_customer.shipping_addresses.new
		@shipping_addresses = current_customer.shipping_addresses.all
	end

	def edit
		@shipping_address = ShippingAddress.find(params[:id])
	end

	def update
		@shipping_address = ShippingAddress.find(params[:id])
		if @shipping_address.update(shipping_address_params)
			redirect_to shipping_addresses_path
		else
			render 'edit'
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

	def correct_customer
		shipping_address = ShippingAddress.find(params[:id])
		unless shipping_address.customer == current_customer
			redirect_to root_path
		end
	end
end

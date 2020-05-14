class Public::CustomersController < Public::Base
	before_action :correct_customer, only: [ :show, :edit]
	# 退会ページの編集
	def withdraw
	end

	def show
	end

	def edit
	end

	def update
		if current_customer.update(customer_params)
			redirect_to customer_path(current_customer)
		else
			render 'edit'
		end
	end

	def leave
		current_customer.update(validness: false)
		reset_session
		flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
		redirect_to root_path
	end



	private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode,:address, :telephone_number, :email, :validness)
    end
    def correct_customer
    	customer = Customer.find(params[:id])
    	unless customer.id == current_customer.id
    		redirect_to root_path
    	end
    end
end

class Public::OrdersController < Public::Base
    before_action :correct_customer, only: [ :show]
    def index
        @orders = Order.all
    end

    def new
        @cart_items = CartItem.where(customer_id: current_customer.id)
        if @cart_items.empty?
            redirect_to cart_items_path
        else
            @order = Order.new
            @customer = Customer.find_by(id: current_customer.id)
            @registered_addresses = ShippingAddress.where(customer_id: current_customer.id)
        end
    end

    def confirm
        @order = Order.new(order_params)
        @customer = Customer.find_by(id: current_customer.id)
        @cart_items = CartItem.all.includes(:item)
        @address_select = params[:address_select]
        @order.carriage = 800
        if @address_select == "ご自身の住所"
            @order.postcode = @customer.postcode
            @order.address = @customer.address
            @order.name = @customer.last_name + @customer.first_name
        elsif @address_select == "登録済住所から選択"
            @shippingaddress = ShippingAddress.where(customer_id: current_customer.id)
            if @shippingaddress.empty?
                flash[:notice] = '配送先を登録してください'
                redirect_to new_order_path
            else
                @order.address
            end
        else
            @postcode = params[:new_postcode]
            @address = params[:new_address]
            @name = params[:new_name]
            if @postcode.empty?
                flash[:notice] = '新しいお届け先を入力してください'
                redirect_to new_order_path
            elsif @address.empty?
                flash[:notice] = '新しいお届け先を入力してください'
                redirect_to new_order_path
            elsif @name.empty?
                flash[:notice] = '新しいお届け先を入力してください'
                redirect_to new_order_path
            else
                @order.postcode = params[:new_postcode]
                @order.address = params[:new_address]
                @order.name = params[:new_name]
            end
        end
    end

    def create
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        @order.save
        current_customer.cart_items.each do |cart_item|
            @order_item = OrderItem.new
            @order_item.order_id = @order.id
            @order_item.item_id = cart_item.item_id
            @order_item.order_price = cart_item.item.price
            @order_item.quantity = cart_item.quantity
            @order_item.save
            cart_item.destroy
        end
        @address_select = params[:address_select]
            if @address_select == "新しいお届け先"
                @shippingaddress = ShippingAddress.new
                @shippingaddress.customer_id = current_customer.id
                @shippingaddress.postcode = @order.postcode
                @shippingaddress.address = @order.address
                @shippingaddress.name = @order.name
                @shippingaddress.save
            end
        redirect_to orders_thanks_path
    end

    def thanks
    end

    def show
        @order = Order.find(params[:id])
        @order_items = OrderItem.where(order_id: @order.id).includes(:item)
        if @order.customer_id == current_customer.id
        else
            redirect_to orders_path
        end
    end

    private
    def order_params
        params.require(:order).permit(:postcode, :address, :name, :payment_method, :carriage, :total_price)
    end

    def correct_customer
        order = Order.find(params[:id])
        unless order.customer_id == current_customer.id
            redirect_to root_path
        end
    end

end
class Public::CartItemsController < Public::Base
    def create
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        if @cart_item.save
            redirect_to item_path(@cart_item.item_id)
        else
            @item = Item.find(@cart_item.item_id)
            @cart = CartItem.new
            render 'public/items/show'
        end
    end

    def index
        @cart_items = CartItem.all.includes(:item)
    end

    def update
        @cart_item = CartItem.find(params[:id])
        if @cart_item.update(cart_item_params)
            redirect_to cart_items_path
        else
            @cart_items = CartItem.all.includes(:item)
            render 'index'
        end
    end

    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_items_path
    end

    private
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :quantity)
    end
end

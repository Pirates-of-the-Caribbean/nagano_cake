class Public::ItemsController <  Public::Base
	def index
		@items = Item.all
		@genres = Genre.all
	end

	def show
		@genres = Genre.all
		@cart_item = CartItem.new
		@item=Item.find(params[:id])
	end
	
end

class Public::ItemsController <  Public::Base
	def index
		@genres = Genre.all
		if params[:genre_id]
		@items=Item.where(genre_id: params[:genre_id])
		else
		@items = Item.all
	end
	end

	def show
		@genres = Genre.all
		if params[:genre_id]
		@items=Item.where(genre_id: params[:genre_id])
		else
		@items = Item.all
		@cart_item = CartItem.new
		@item=Item.find(params[:id])
	end
	end
	
end

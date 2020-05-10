class Public::ItemsController <  Public::Base
	before_action :authenticate_customer!, except: [:index, :show]
	def index
		@genres = Genre.all
		if params[:genre_id]
		@items=Item.where(genre_id: params[:genre_id])
		else
		@items = Item.page(params[:page]).reverse_order
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

class Admin::ItemsController <Admin::Base

def index
	@items=Item.page(params[:page]).reverse_order.per(10)
end

def new
    @item=Item.new
end

def show
@item=Item.find(params[:id])
end

def edit
@item=Item.find(params[:id])
end

def create
@item=Item.new(item_params)
 # if 
  @item.save
 redirect_to  admin_item_path(@item)
 # else
 # render"new"
 # end
end

def update
@item=Item.find(params[:id])
@item.update(item_params)
redirect_to admin_item_path(@item)
end
 private
    def item_params
      params.require(:item).permit(:name, :price, :detail,:genre_id, :image, :sale_status,)
    end

end


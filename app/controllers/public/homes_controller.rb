class Public::HomesController < Public::Base
	before_action :authenticate_customer!, except: [:top]
  def top
    @genres = Genre.all

    #商品更新順を降順で4つ取得(おすすめ表示用)
    @items = Item.all.order("updated_at DESC").limit(4)
  end
end

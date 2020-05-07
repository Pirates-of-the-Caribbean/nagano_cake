class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all.includes(:order_items)
  end

  def show
    # orderに紐つくorder_itemが持つitemの名前などを持ってくる
    @order = Order.find(params[:id])
    @order_items = OrderItem.all.includes(:item)
    @order_item = OrderItem.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
      # order.status更新後、statusが"入金確認"なら
  if order.status == "入金確認"
    # orderに紐づくorder_itemsのproduction_statusを全て"製作待ち"に更新
    order.order_items.each do |order_item|
      order_item.update(production_status: "製作待ち")
    end
  end
    redirect_to admin_order_path(order)
  end

private
  def order_params
    params.require(:order).permit(:status)
  end


  # def update 「なにこれ？？」
  #   # order/showから渡ってきたorder_idを参照してorderに情報を入れる
  #   order = Order.find(params[:id])
  #   # order_itemsに上で指定したorderに紐付くorder_itemを全て入れる
  #   order_items = order.order_items.all

  # end

  # !未実装!　紐付くorder_itemのproductionが一つでも製作中(2)になれば「orderのstatusを製作中(2)」に自動更新
  # !未実装!　紐付く注文商品の製作ステータスが全て「制作完了」になれば「発送準備中」に自動更新

  # enum production_status:{
  #       着手不可: 0,
  #       製作待ち: 1,
  #       製作中: 2,
  #       製作完了: 3
  #   }

  # enum (order)status:{
  #       入金待ち: 0,
  #       入金確認: 1,
  #       製作中: 2,
  #       発送準備中: 3,
  #       発送済み: 4
  #   }

end

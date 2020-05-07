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

end

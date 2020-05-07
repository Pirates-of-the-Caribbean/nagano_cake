class Admin::OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find(params[:id])
    # order_item_params(production_status)の値を更新
    order_item.update(order_item_params)


  # order_item.production_status更新後、production_statusが"製作中"になれば
    if order_item.production_status == "製作中"
      # order_item.orderのstatusを"製作中"に更新
      order_item.order.update(status: "製作中")
    end

    #order_item.production_status更新後、「製作完了」になれば
    # (「order_item.statusが「製作完了」になったタイミングでないと全て「製作完了」の状態にならないと思う。反例が出なければこのままで。)
    if order_item.production_status == "製作完了"
      # order_item.order.order_items.production_statusが全て「製作完了」かどうかを判定して
      if order_item.order.order_items.all?{|order_item| order_item.production_status == "製作完了"}
        # all?{|ブロック変数| 条件}で条件が全て一致するならtrue

        # trueならorder.statusを"発送準備中"に更新
        order_item.order.update(status: "発送準備中")

      end
    end
    # order_itemをもっているorderのidのページに飛ぶ
    redirect_to admin_order_path(order_item.order_id)
  end

  

  private
  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
end

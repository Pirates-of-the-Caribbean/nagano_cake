class Admin::HomesController < Admin::Base

  # 当日の注文数を表示
  def top
    @orders = Order.where("created_at >= ?", Date.today)
  end
end

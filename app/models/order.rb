class Order < ApplicationRecord
    has_many :order_items,dependent: :destroy
    belongs_to :customer
    enum status:{
        入金待ち: 0,
        入金確認: 1,
        製作中: 2,
        発送準備中: 3,
        発送済み: 4
    }
    # def subtotal
    #     order_item.order_price * order_item.quantity
    # end
    
    # def total_quantity
    #     total = 0
    #     order_items.each do |order_item|
    #         total += order_items.count
    #     end
    #     total
    # end

end

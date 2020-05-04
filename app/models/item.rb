class Item < ApplicationRecord
    has_many :order_items,dependent: :destroy
    has_many :cart_items,dependent: :destroy
    belongs_to :genre
    attachment :image
    enum sale_status: { 販売中: 0, 販売停止中: 1 }
end

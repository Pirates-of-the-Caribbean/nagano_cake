class ChangeColumnToOrderItem < ActiveRecord::Migration[5.2]
  def change
    change_column :order_items, :production_status, :integer, default: 0
  end
end

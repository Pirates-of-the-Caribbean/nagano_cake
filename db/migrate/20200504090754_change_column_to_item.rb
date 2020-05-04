class ChangeColumnToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :sale_status, :integer, default: 0
  end
end

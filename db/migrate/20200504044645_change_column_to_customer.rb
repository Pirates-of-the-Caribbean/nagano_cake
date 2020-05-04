class ChangeColumnToCustomer < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :last_name, :string, default: "", null: false
    change_column :customers, :first_name, :string, default: "", null: false
    change_column :customers, :last_name_kana, :string, default: "", null: false
    change_column :customers, :first_name_kana, :string, default: "", null: false
    change_column :customers, :postcode, :string, default: "", null: false
    change_column :customers, :address, :string, default: "", null: false
    change_column :customers, :telephone_number, :string, default: "", null: false
    change_column :customers, :validness, :boolean, default: true, null: false
  end
end

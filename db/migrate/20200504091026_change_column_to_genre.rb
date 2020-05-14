class ChangeColumnToGenre < ActiveRecord::Migration[5.2]
  def change
    change_column :genres, :valid_flag, :boolean, default: true
  end
end

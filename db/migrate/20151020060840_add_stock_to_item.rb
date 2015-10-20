class AddStockToItem < ActiveRecord::Migration
  def change
    add_column :items, :stock, :integer, default: 10
  end
end

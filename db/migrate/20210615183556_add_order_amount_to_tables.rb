class AddOrderAmountToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :order_amount, :float
  end
end

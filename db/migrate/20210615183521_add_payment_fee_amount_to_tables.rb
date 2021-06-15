class AddPaymentFeeAmountToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :payment_fee_amount, :float
  end
end

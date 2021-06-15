class AddPaymentDueDateToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :payment_due_date, :datetime
  end
end

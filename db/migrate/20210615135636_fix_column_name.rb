class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :terminals, :type, :payment_type
  end
end

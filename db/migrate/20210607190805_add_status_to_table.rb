class AddStatusToTable < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :status, :string, default: 'available'
  end
end

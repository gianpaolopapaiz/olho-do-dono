class RemoveStatusOfTables < ActiveRecord::Migration[6.0]
  def change
    remove_column :tables, :status
  end
end

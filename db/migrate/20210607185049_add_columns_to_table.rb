class AddColumnsToTable < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :rating, :integer
    add_column :tables, :comment, :text
  end
end

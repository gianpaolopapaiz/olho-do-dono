class AddColumnToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :nbr_of_tables, :integer
  end
end

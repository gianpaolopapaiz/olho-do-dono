class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :category
      t.string :name
      t.string :description
      t.float :price
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

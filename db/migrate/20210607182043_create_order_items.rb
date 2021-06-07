class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :product_quantity
      t.string :observation
      t.references :product, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true

      t.timestamps
    end
  end
end

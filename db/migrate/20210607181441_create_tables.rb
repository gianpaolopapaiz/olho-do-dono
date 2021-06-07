class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.integer :number
      t.string :status
      t.string :payment_type
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

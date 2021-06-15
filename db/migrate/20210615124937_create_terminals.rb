class CreateTerminals < ActiveRecord::Migration[6.0]
  def change
    create_table :terminals do |t|
      t.string :name
      t.string :flag
      t.string :type
      t.integer :payment_day
      t.integer :closing_day
      t.float :fee_percentage
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class AddTerminalToTables < ActiveRecord::Migration[6.0]
  def change
    add_reference :tables, :terminal, foreign_key: true
  end
end

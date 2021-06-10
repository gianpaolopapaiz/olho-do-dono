class AddStatusToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :status, :string, default: 'placed'
  end
end

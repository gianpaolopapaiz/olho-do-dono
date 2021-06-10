class OrderItemsController < ApplicationController
  def create
    order_item = OrderItem.new
    table = Table.find(params[:table_id])
    product_quantity = params[:order_item][:product_quantity]
    product = Product.find(params[:order_item][:product_id])
    order_item.product_quantity = product_quantity
    order_item.product = product
    order_item.table = table
    order_item.save
    redirect_to "/restaurants/#{table.restaurant.id}/spaces/#{table.number}/tables/#{table.id}"
  end
end

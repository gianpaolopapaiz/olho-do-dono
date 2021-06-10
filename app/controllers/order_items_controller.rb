class OrderItemsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
    @order_items = @restaurant.order_items
  end
  
  def create
    order_item = OrderItem.new
    table = Table.find(params[:table_id])
    product_quantity = params[:order_item][:product_quantity]
    product = Product.find(params[:order_item][:product_id])
    order_item.product_quantity = product_quantity
    order_item.product = product
    order_item.table = table
    order_item.status = 'placed'
    if !order_item.save
      flash[:alert] = 'Something went wrong'
    end
    redirect_to "/restaurants/#{table.restaurant.id}/spaces/#{table.number}/tables/#{table.id}"
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    if !order_item.destroy
      flash[:alert] = 'Something went wrong'
    end
    redirect_to "/restaurants/#{order_item.table.restaurant.id}/spaces/#{order_item.table.number}/tables/#{order_item.table.id}"
  end
end

class OrderItemsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
    @order_items = @restaurant.order_items.where("order_items.status = ? OR order_items.status = ?", 'placed', 'preparing').order(:created_at)
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
    if order_item.save 
      RestaurantChannel.broadcast_to(
        order_item.table.restaurant,
        render_to_string(partial: "order_item", locals: { order_item: order_item })
      )
      redirect_to restaurant_table_show_path(table.restaurant, table.number, table)
    else
      flash[:alert] = 'Something went wrong'
      redirect_to restaurant_table_show_path(table.restaurant, table.number, table)
    end
  end
  
  def update
    order_item = OrderItem.find(params[:id])
    if order_item.status == 'placed'
      order_item.status = 'preparing'
    elsif order_item.status == 'preparing'
      order_item.status = 'ready'
    end
    if order_item.save 
      TableChannel.broadcast_to(
        order_item.table,
        render_to_string(partial: "order_item_status", locals: { order_item: order_item })
      )
      redirect_to restaurant_order_items_path(order_item.table.restaurant)
    else
      flash[:alert] = 'Something went wrong'
      redirect_to restaurant_order_items_path(order_item.table.restaurant)
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    if !order_item.destroy
      flash[:alert] = 'Something went wrong'
    end
    redirect_to "/restaurants/#{order_item.table.restaurant.id}/spaces/#{order_item.table.number}/tables/#{order_item.table.id}"
  end

end

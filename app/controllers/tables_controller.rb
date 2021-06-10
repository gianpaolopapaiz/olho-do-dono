class TablesController < ApplicationController

  def show
    @table = Table.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.user != current_user
      flash[:alert] = 'Not authorized'
      redirect_to restaurants_path
    end
    @products = @restaurant.products
    @foods = @products.where(category: 'Food')
    @beverages = @products.where(category: 'Beverage')
    @desserts = @products.where(category: 'Dessert')
    @order_item = OrderItem.new
    @order_items = @table.order_items
    @sum = @order_items
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.user != current_user
      flash[:alert] = 'Not authorized'
      redirect_to restaurants_path
    end
    @number = params[:number]
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    if restaurant.user != current_user
      flash[:alert] = 'Not authorized'
      redirect_to restaurants_path
    end
    number = params[:number]
    table = Table.new
    table.restaurant = restaurant
    table.number = number
    table.status = 'open'
    if restaurant.tables.where("number = #{number} AND status = 'open'").length > 0
      flash[:alert] = 'Table already has an open session'
      redirect_to "/restaurants/#{restaurant.id}/spaces/#{number}/tables/new"
    else
      if table.save
        redirect_to "/restaurants/#{restaurant.id}/spaces/#{number}/tables/#{table.id}"
      else
        flash[:alert] = table.errors.messages
        redirect_to "/restaurants/#{restaurant.id}/spaces/#{number}/tables/new"
      end
    end
  end

  def update
    table = Table.find(params[:id])
    if !table.update(table_params)
      flash[:alert] = table.errors.messages
    end
    redirect_to "/restaurants/#{table.restaurant.id}/spaces/#{table.number}/tables/#{table.id}"
  end

  def close
    restaurant = Restaurant.find(params[:restaurant_id])
    if restaurant.user != current_user
      redirect_to restaurants_path
    end
    table = Table.find(params[:id])
    number = table.number
    table.status = 'closed'
    if table.save
      redirect_to "/restaurants/#{restaurant.id}/spaces/#{number}/tables/new"
    else
      flash[:alert] = table.errors.messages
      redirect_to "/restaurants/#{restaurant.id}/spaces/#{@number}/tables/#{table.id}"
    end
  end

  private

  def table_params
    params.require(:table).permit(:payment_type, :rating, :comment)
  end

end

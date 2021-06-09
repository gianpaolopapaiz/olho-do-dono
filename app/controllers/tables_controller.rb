class TablesController < ApplicationController

  def show
    @table = Table.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.user != current_user
      redirect_to restaurants_path
    end
    @products = @restaurant.products
    @foods = @products.where(category: 'Food')
    @beverages = @products.where(category: 'Beverage')
    @desserts = @products.where(category: 'Dessert')
    @order_item = OrderItem.new
    @order_items = @table.order_items
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.user != current_user
      redirect_to restaurants_path
    end
    @number = params[:number]
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    if restaurant.user != current_user
      redirect_to restaurants_path
    end
    @number = params[:number]
    table = Table.new
    table.restaurant = restaurant
    table.number = @number
    table.status = 'open'
    @message = ''
    if restaurant.tables.where("number = #{@number} AND status = 'open'").length > 0
      @message = 'Table has open session already!'
    else
      if table.save
        redirect_to "/restaurants/#{restaurant.id}/spaces/#{@number}/tables/#{table.id}"
      else
        @message = 'Opening table error!'
      end
    end
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
      render :show
    end
  end

end

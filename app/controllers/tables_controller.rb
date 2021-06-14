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
    if @table.rating
      redirect_to "/restaurants/#{@table.restaurant.id}/spaces/#{@table.number}/tables/new"
    end
    
    if @table.status == 'waiting'
      close_order_items
      sleep(5)
      @table.status = 'closed'
      @table.save
      # redirect_to "/restaurants/#{@table.restaurant.id}/spaces/#{@table.number}/tables/#{@table.id}"
      # render :show
    end
    
    if @table.payment_type && @table.status == 'open'
      @table.status = 'waiting'
      @table.save
      # redirect_to "/restaurants/#{@table.restaurant.id}/spaces/#{@table.number}/tables/#{@table.id}"
      render :show
    end

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
    update_restaurant_rating(table) if table.rating
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
  
  def close_order_items
    table = Table.find(params[:id])
    order_items = table.order_items
    order_items.each do |item|
      item.status = 'paid'
      item.save
    end
  end

  def update_restaurant_rating(table)
    restaurant = table.restaurant
    sum = 0
    count = 0
    restaurant.tables.where('rating > 0').each do |table|
      sum += table.rating
      count += 1
    end
    rating_avg = sum / count
    restaurant.rating_avg = rating_avg
    restaurant.save 
  end

  private

  def table_params
    params.require(:table).permit(:payment_type, :rating, :comment)
  end


end

class RestaurantsController < ApplicationController

  def index
    @restaurants = current_user.restaurants.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    items = @restaurant.order_items.where(status: 'paid')
    today_year = Date.today.year
    today_month = Date.today.month
    today_day = Date.today.day
    @year_amount = 0
    @year_order_qty = 0
    @month_amount = 0
    @month_order_qty = 0
    @day_amount = 0
    @day_order_qty = 0
    items.each do |item|
      if item.updated_at.year == today_year
        @year_amount += item.product_quantity * item.product.price
        @year_order_qty += 1
        if item.updated_at.month == today_month
          @month_amount += item.product_quantity * item.product.price
          @month_order_qty += 1
          if item.updated_at.day == today_day
            @day_amount += item.product_quantity * item.product.price
            @day_order_qty += 1
          end  
        end
      end
    end
    @nbr_foods = @restaurant.products.where(category: 'Food').count
    @nbr_beverages = @restaurant.products.where(category: 'Beverage').count
    @nbr_desserts = @restaurant.products.where(category: 'Dessert').count
    @expense_hash = @restaurant.expenses.where('due_date >?', Date.today).each_with_object(Hash.new(0)) {|expense, hash| hash[expense.category] += expense.amount }
    
  end

  def new
    @restaurant = Restaurant.new()
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to restaurants_path, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end  
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy    
    redirect_to restaurants_path, notice: 'Restaurant was successfully destroyed.'
  end

  private


  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone, :nbr_of_tables, :photo)
  end
end

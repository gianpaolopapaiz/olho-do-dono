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

    food_orders = @restaurant.order_items.joins("INNER JOIN products ON order_items.product_id = products.id AND products.category = 'Food' and order_items.status = 'paid'")
    food_qty_hash = food_orders.each_with_object(Hash.new(0)) {|item, hash| hash[item.product.name] += item.product_quantity }
    food_qty_hash = food_qty_hash.sort_by {|k,v| v}.reverse
    food_amount_hash = food_orders.each_with_object(Hash.new(0)) {|item, hash| hash[item.product.name] += item.product_quantity * item.product.price }
    food_amount_hash = food_amount_hash.sort_by {|k,v| v}.reverse

    beverage_orders = @restaurant.order_items.joins("INNER JOIN products ON order_items.product_id = products.id AND products.category = 'Beverage' and order_items.status = 'paid'")
    beverage_qty_hash = beverage_orders.each_with_object(Hash.new(0)) {|item, hash| hash[item.product.name] += item.product_quantity }
    beverage_qty_hash = beverage_qty_hash.sort_by {|k,v| v}.reverse
    beverage_amount_hash = beverage_orders.each_with_object(Hash.new(0)) {|item, hash| hash[item.product.name] += item.product_quantity * item.product.price }
    beverage_amount_hash = beverage_amount_hash.sort_by {|k,v| v}.reverse

    dessert_orders = @restaurant.order_items.joins("INNER JOIN products ON order_items.product_id = products.id AND products.category = 'Dessert' and order_items.status = 'paid'")
    dessert_qty_hash = dessert_orders.each_with_object(Hash.new(0)) {|item, hash| hash[item.product.name] += item.product_quantity }
    dessert_qty_hash = dessert_qty_hash.sort_by {|k,v| v}.reverse    
    dessert_amount_hash = dessert_orders.each_with_object(Hash.new(0)) {|item, hash| hash[item.product.name] += item.product_quantity * item.product.price }
    dessert_amount_hash = dessert_amount_hash.sort_by {|k,v| v}.reverse
    if food_orders.count > 0
      @item1_name = food_qty_hash[0][0] 
      @item1 = food_qty_hash[0][1]
    else
      @item1_name = "" 
      @item1 = 0
    end
    if beverage_orders.count > 0
      @item2_name = beverage_qty_hash[0][0] 
      @item2 = beverage_qty_hash[0][1]
    else
      @item2_name = "" 
      @item2 = 0
    end
    if dessert_orders.count > 0
      @item3_name = dessert_qty_hash[0][0] 
      @item3 = dessert_qty_hash[0][1]
    else
      @item3_name = "" 
      @item3 = 0
    end
    @amount1 = ""
    @amount2 = ""
    @amount3 = ""
    @amount1 = "#{food_amount_hash[0][0]} $#{food_amount_hash[0][1]}0" if food_orders.count > 0
    @amount2 = "#{beverage_amount_hash[0][0]} $#{beverage_amount_hash[0][1]}0" if beverage_orders.count > 0
    @amount3 = "#{dessert_amount_hash[0][0]} $#{dessert_amount_hash[0][1]}0" if dessert_orders.count > 0
    total = 0
    food_amount_hash.each {|k, v| total += v }
    @tot_amount1 =total
    total = 0
    beverage_amount_hash.each {|k, v| total += v }
    @tot_amount2 =total
    total = 0
    dessert_amount_hash.each {|k, v| total += v }
    @tot_amount3 =total

    @comment_tables = @restaurant.tables.where("comment != ''").order(updated_at: :desc)
  end

  def new
    @restaurant = Restaurant.new()
  end

  def cashflow
    @restaurant = Restaurant.find(params[:restaurant_id])
    today_year = Date.today.year
    today_month = Date.today.month
    today_day = Date.today.day
    @cashflow_food = Hash.new(0)
    @cashflow_beverage = Hash.new(0)
    @cashflow_dessert = Hash.new(0)
    @total_revenue = Hash.new(0)

    items = @restaurant.order_items.where(status: 'paid')
    items.each do |item|
      if item.table.payment_due_date.year == today_year

        @cashflow_food[item.table.payment_due_date.month] += item.product_quantity * item.product.price  if item.product.category == 'Food'
        @cashflow_beverage[item.table.payment_due_date.month] += item.product_quantity * item.product.price if item.product.category == 'Beverage'
        @cashflow_dessert[item.table.payment_due_date.month] += item.product_quantity * item.product.price if item.product.category == 'Dessert'
      end
    end
    for i in 1..12 do
      if @cashflow_food[i] + @cashflow_beverage[i] + @cashflow_dessert[i] > 0
        @total_revenue[i] += @cashflow_food[i] + @cashflow_beverage[i] + @cashflow_dessert[i]  
      end
    end
    @total_revenue = @total_revenue.sort_by {|k,v| k}    
    @cashflow_payroll = Hash.new(0)
    @cashflow_rent = Hash.new(0)
    @cashflow_input = Hash.new(0)
    @cashflow_office = Hash.new(0)
    @total_expenses = Hash.new(0)
    expenses = @restaurant.expenses
    expenses.each do |item|
      @cashflow_payroll[item.due_date.month] += item.amount if item.due_date.year == today_year && item.category == 'Payroll'
      @cashflow_office[item.due_date.month] += item.amount if item.due_date.year == today_year && item.category == 'Office'
      @cashflow_input[item.due_date.month] += item.amount if item.due_date.year == today_year && item.category == 'Inputs'
      @cashflow_rent[item.due_date.month] += item.amount if item.due_date.year == today_year && item.category == 'Rent&Utilities'
    end
     for i in 1..12 do
      if @cashflow_payroll[i] + @cashflow_office[i] + @cashflow_input[i] + @cashflow_rent[i] > 0
        @total_expenses[i] += @cashflow_payroll[i] + @cashflow_office[i] + @cashflow_input[i] + @cashflow_rent[i]  
      end
    end
    @total_expenses = @total_expenses.sort_by {|k,v| k} 
    @balance = Hash.new(0)
    for i in 1..12 do
      if @total_revenue[i]
        if @total_expenses[i]
          @balance[i] = @total_revenue[i] - @total_expenses[i]  
        else
          @balance[i] = @total_revenue[i]
        end
      else
        if @total_expenses[i]
          @balance[i] =  @total_expenses[i]  
        end
      end
    end
    @balance = @balance.sort_by {|k,v| k} 
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

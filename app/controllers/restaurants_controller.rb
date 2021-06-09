class RestaurantsController < ApplicationController

  def index
    @restaurants = current_user.restaurants.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
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

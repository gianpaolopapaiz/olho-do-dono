class ProductsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @products = @restaurant.products
    @foods = @products.where(category: 'Food')
    @beverages = @products.where(category: 'Beverage')
    @desserts = @products.where(category: 'Dessert')
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @product = Product.new(product_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @product.restaurant = @restaurant
    if @product.save
      flash[:success] = "Product successfully created"
      redirect_to restaurant_products_path(@restaurant)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to restaurant_products_path(@product.restaurant)
      else
        render :edit
      end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to restaurant_products_path(@product.restaurant)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :photo)
  end
end

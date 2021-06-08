class ProductsController < ApplicationController
  def index
    @products = Product.all
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

  private

  def product_params
    params.require(:products).permit(:name, :description, :price, :category, :photo)
  end
end

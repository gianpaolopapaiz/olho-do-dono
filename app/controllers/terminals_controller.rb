class TerminalsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
    @terminals = @restaurant.terminals.order(name: :asc)
  end

  def new
    @terminal = Terminal.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
  end

  def create
    @terminal = Terminal.new(terminal_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
    @terminal.restaurant = @restaurant
    if @terminal.save
      flash[:success] = "Terminal successfully created"
      redirect_to restaurant_terminals_path(@restaurant)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
    @terminal = Terminal.find(params[:id])
    redirect_to restaurants_path if @terminal.restaurant.user != current_user
  end

  def update
    @terminal = Terminal.find(params[:id])
    redirect_to restaurants_path if @terminal.restaurant.user != current_user
      if @terminal.update(terminal_params)
        redirect_to restaurant_terminals_path(@terminal.restaurant)
      else
        render :edit
      end
  end

  def destroy
    @terminal = Terminal.find(params[:id])
    redirect_to restaurants_path if @terminal.restaurant.user != current_user
    @terminal.destroy
    redirect_to restaurant_terminals_path(@terminal.restaurant)
  end

  private

  def terminal_params
    params.require(:terminal).permit(:name, :flag, :payment_type, :payment_day, :closing_day, :fee_percentage)
  end

end

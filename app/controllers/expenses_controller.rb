class ExpensesController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @expense.restaurant = @restaurant
    if @expense.save
      redirect_to restaurant_expenses_path(@restaurant)
    else
      render :new
    end
  end

  def index
    @expenses = Expense.all
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :category, :amount, :due_date)
  end


end

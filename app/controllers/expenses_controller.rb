class ExpensesController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @expenses = @restaurant.expenses
  end
    
  def new
    @expense = Expense.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @expense = Expense.new(expense_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @expense.restaurant = @restaurant
    if @expense.save
      flash[:success] = "Product successfully created"
      redirect_to restaurant_expenses_path(@restaurant)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
      if @expense.update(expense_params)
        redirect_to restaurant_expenses_path(@expense.restaurant)
      else
        render :edit
      end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to restaurant_expenses_path(@expense.restaurant)
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to restaurant_expenses_path(@expense.restaurant)
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :category, :amount, :due_date)
  end


end

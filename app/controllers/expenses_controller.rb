class ExpensesController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
    @expenses = @restaurant.expenses
    @payrolls = @expenses.where(category: 'Payroll').order(due_date: :asc)
    @renteutilities = @expenses.where(category: 'Rent&Utilities').order(due_date: :asc)
    @offices = @expenses.where(category: 'Office').order(due_date: :asc)
    @inputs = @expenses.where(category: 'Inputs').order(due_date: :asc)
  end
    
  def new
    @expense = Expense.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
  end

  def create
    @expense = Expense.new(expense_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    redirect_to restaurants_path if @restaurant.user != current_user
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
    redirect_to restaurants_path if @expense.restaurant.user != current_user
  end

  def update
    @expense = Expense.find(params[:id])
    redirect_to restaurants_path if @expense.restaurant.user != current_user
      if @expense.update(expense_params)
        redirect_to restaurant_expenses_path(@expense.restaurant)
      else
        render :edit
      end
  end

  def destroy
    @expense = Expense.find(params[:id])
    redirect_to restaurants_path if @expense.restaurant.user != current_user
    @expense.destroy
    redirect_to restaurant_expenses_path(@expense.restaurant)
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :category, :amount, :due_date)
  end


end

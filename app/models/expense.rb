class Expense < ApplicationRecord
  belongs_to :restaurant
  validates :description, :category, :amount, :due_date, presence: true
  validates :category, inclusion: { in: %w[Payroll Rent&Utilities Office Inputs]}
end

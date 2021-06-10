class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :table
  validates :product_quantity, :status, presence: true
  validates :status, inclusion: { in: %w[placed, preparing, ready]}
  validates_numericality_of :product_quantity, :greater_than => 0.0
end

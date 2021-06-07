class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :table
  validates :product_quantity, presence: true
  validates_numericality_of :product_quantity, :greater_than => 0.0
end

class Product < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :photo
  validates :name, :description, :price, presence: true
  validates :category, inclusion: { in: %w[food beverage dessert]}
  validates_numericality_of :price, :greater_than => 0.0
end

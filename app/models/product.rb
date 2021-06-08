class Product < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :photo
  validates :name, :description, :price, presence: true
  validates :category, inclusion: { in: %w[Food Beverage Dessert]}
  validates_numericality_of :price, :greater_than => 0.0
  validates_uniqueness_of :name, scope: :restaurant
end

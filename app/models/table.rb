class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  has_many :products, through: :order_items
  validates :number, :status, presence: true
  validates :status, inclusion: { in: %w[available open closed]}

end

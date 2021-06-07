class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  has_many :products, through: :order_items
  validates :number, :status, :payment_types, presence: true
  validates :status, inclusion: { in: %w[available occupied closed]}

end

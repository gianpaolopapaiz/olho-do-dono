class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  has_many :products, through: :order_items
  validates :number, :status, presence: true
  validates :status, inclusion: { in: %w[available open closed]}

  def total
    sum = 0
    order_items.each do |item| 
      sum += item.product_quantity * item.product.price
    end
    sum  
  end
end

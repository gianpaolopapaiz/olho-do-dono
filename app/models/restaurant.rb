class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  has_many :tables, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :order_items, through: :tables
  validates :name, :address, :phone, presence: true
end

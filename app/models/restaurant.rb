class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  has_many :tables, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :order_items, through: :tables
  has_one_attached :photo
  validates :name, :address, :phone, :nbr_of_tables, presence: true
end

class Terminal < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :photo
  validates :name, :flag, :payment_type, :payment_day, :closing_day, :fee_percentage, presence: true
  validates :flag, inclusion: { in: %w[Mastercard Visa Amex VisaElectron Maestro]}
  validates :payment_type, inclusion: { in: %w[Credit Debit]}
  validates_numericality_of :fee_percentage, :greater_than => 0.0
  validates_inclusion_of :payment_day, :in => 1..31
  validates_inclusion_of :closing_day, :in => 1..31
  validates_uniqueness_of :name, scope: :restaurant
end

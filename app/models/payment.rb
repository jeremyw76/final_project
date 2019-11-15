class Payment < ApplicationRecord
  belongs_to :payment_method
  belongs_to :order

  validates :payment_method, presence: true
  validates :order, presence: true
  validates :amount, presence: true
end

class PaymentMethod < ApplicationRecord
  belongs_to :customer

  validates :payment_token, presence: true
  validates :card_type, presence: true
end

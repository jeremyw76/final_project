class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items, dependent: :destroy
  has_many :payments
  belongs_to :address

  validates :customer, presence: true
end

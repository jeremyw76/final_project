class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items, dependent: :destroy
  has_many :payments
  belongs_to :address

  validates :customer, presence: true

  def get_subtotal
    line_items.reduce(0) {|sum, item| sum + (item.quantity * item.value) }
  end

  def get_taxes_total
    line_items.reduce(0) {|sum, item| sum + item.taxes.reduce(0) {|total, tax| total + tax.amount}}
  end

  def get_total
    self.get_taxes_total + self.get_subtotal
  end
end

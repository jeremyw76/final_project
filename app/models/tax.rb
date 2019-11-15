class Tax < ApplicationRecord
  belongs_to :line_item

  validates :line_item, presence: true
  validates :code, presence: true
  validates :rate, presence: true
  validates :rate, numericality: true
  validates :amount, presence: true
  validates :amount, numericality: true
end

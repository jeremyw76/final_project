class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, polymorphic: true
  has_many :taxes

  validates :order, presence: true
  validates :item_type, presence: true
  validates :item, presence: true
  validates :quantity, presence: true
  validates :value, presence: true
  validates :value, numericality: true
  validates :taxable, presence: true
end

class Package < ApplicationRecord
  has_many :line_items, as: :item

  validates :description, presence: true
  validates :rules, presence: true
end

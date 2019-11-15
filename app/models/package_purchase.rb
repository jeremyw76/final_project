class PackagePurchase < ApplicationRecord
  belongs_to :line_item

  validates :line_item, presence: true
  validates :description, presence: true
  validates :rules, presence: true
end

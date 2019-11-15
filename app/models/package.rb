class Package < ApplicationRecord
  validates :description, presence: true
  validates :rules, presence: true
end

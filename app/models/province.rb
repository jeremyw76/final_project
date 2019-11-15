class Province < ApplicationRecord
  validates :name, presence: true
  validates :province_code, presence: true
  validates :province_code, format: { with: /\A[A-Za-z]{2}\z/, on: :create }
  validates :tax_rate, presence: true
  validates :tax_rate, numericality: true
  validates :tax_code, presence: true
  validates :tax_code, format: { with: /\A[A-Z]\z/, on: :create }
end

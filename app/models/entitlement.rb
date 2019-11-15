class Entitlement < ApplicationRecord
  belongs_to :customer
  belongs_to :photo

  validates :customer, presence: true
  validates :photo, presence: true
  validates :hash, presence: true
  validates :hash_expiry, presence: true
  validates :entitlement_expiry, presence: true
end

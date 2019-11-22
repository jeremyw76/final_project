class Customer < ApplicationRecord
  belongs_to :user
  has_many :addresses

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, uniqueness: true
end

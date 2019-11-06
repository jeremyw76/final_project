class Entitlement < ApplicationRecord
  belongs_to :customer
  belongs_to :photo
end

class Address < ApplicationRecord
  belongs_to :customer
  belongs_to :province

  validates :customer, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :postal_code, presence: true

  validate :correct_postal_code_format

  def correct_postal_code_format
    if postal_code != nil && postal_code.length == 6 then
      postal_code.insert(3, ' ')
    end

    /\A(?!.*[DFIOQU])[A-VXY][0-9][A-Z][' '][0-9][A-Z][0-9]\z/.match(postal_code)
  end
end

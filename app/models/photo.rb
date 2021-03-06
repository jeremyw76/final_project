class Photo < ApplicationRecord
  has_one_attached :image
  has_many :line_items, as: :item
  has_many :photo_tags
  has_many :tags, through: :photo_tags

  validates :description, presence: true
  validates :value, presence: true

  validate :correct_document_mime_type

  def display_price
    value.to_f / 100
  end

  def correct_document_mime_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png))
      image = nil
      errors.add(:image, 'Must be an image file')
    end
  end
end

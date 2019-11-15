class PhotoTag < ApplicationRecord
  belongs_to :photo
  belongs_to :tag

  validates :photo, presence: true
  validates :tag, presence: true
end

class PhotosController < ApplicationController

  def index
    index = 0

    photo_data = Photo.all.with_attached_image.map do | photo |
      {
        id: index,
        small_url: small_image_url(photo),
        large_url: large_image_url(photo),
        description: photo.description,
        price: photo.value
      }
    end

    render json: { images: photo_data }
  end

  def show
  end

  def small_image_url(photo)
    if photo.image.attached?
      rails_representation_url(photo.image.variant(resize: "600x600^"))
    else
      nil
    end
  end

  def large_image_url(photo)
    if photo.image.attached?
      rails_representation_url(photo.image.variant(resize:"1000x1000"))
    else
      nil
    end
  end
end

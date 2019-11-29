class PhotosController < ApplicationController

  def index
    page = params.key?(:page) ? params[:page] - 1 : 0
    per_page = params.key?(:per_page) ? params[:per_page] : 10

    photo_count = Photo.count
    max_pages = photo_count / per_page

    page = max_pages if page > max_pages
    page = 0 if page < 0

    offset = page * per_page

    photo_data = Photo.all.offset(offset).limit(per_page).with_attached_image.map do | photo |
      {
        id: photo.id,
        small_url: small_image_url(photo),
        large_url: large_image_url(photo),
        description: photo.description,
        price: photo.display_price,
        price_in_cents: photo.value
      }
    end

    render json: { images: photo_data, page: 1, per_page: 10, pages: max_pages }
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

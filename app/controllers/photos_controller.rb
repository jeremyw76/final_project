class PhotosController < ApplicationController

  def index
    render json: { images: Photo.all.with_attached_image.map do | photo |
      puts photo.image
      if photo.image.attached?
        puts 'Yes attached sdfsdfsnow'
        rails_representation_url(photo.image.variant(resize: "600x600^"))
        # Application.routes.url_helpers.get_url(photo.image)
      else
        nil
      end
    end}
  end

  def show
  end
end

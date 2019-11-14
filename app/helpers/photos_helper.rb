module PhotosHelper
  def self.small_image_url(photo)
    if photo.image.attached?
      rails_representation_url(photo.image.variant(resize: "600x600^"))
    else
      nil
    end
  end
end

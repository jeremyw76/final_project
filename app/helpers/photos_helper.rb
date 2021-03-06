module PhotosHelper
  class Pagination
    include Rails.application.routes.url_helpers

    def initialize(relation = Photo.all)
      @relation = relation
    end

    def paginated(page, per_page)
      per_page = @relation.size if per_page == nil
      max_pages = (@relation.size / per_page.to_f).ceil
      page = [page, max_pages].min
      offset = [page - 1, 0].max * per_page

      photo_data = @relation.offset(offset).limit(per_page).with_attached_image.map do | photo |
        {
          id: photo.id,
          small_url: small_image_url(photo),
          large_url: large_image_url(photo),
          description: photo.description,
          price: photo.display_price,
          price_in_cents: photo.value
        }
      end

      { images: photo_data, page: page, per_page: per_page, pages: max_pages }
    end

    def small_image_url(photo)
      if photo.image.attached?
        Rails.application.routes.url_helpers.rails_representation_url(photo.image.variant(resize: "600x600^").processed, host: 'http://localhost:3000')
      else
        nil
      end
    end

    def large_image_url(photo)
      if photo.image.attached?
        Rails.application.routes.url_helpers.rails_representation_url(photo.image.variant(resize:"1000x1000").processed, host: 'http://localhost:3000')
      else
        nil
      end
    end
  end

  class Filter
    def initialize(relation = Photo.all)
      @relation = relation
    end
  end

  class IdFilter < Filter
    def subset_for_ids(ids = nil)
      unless ids == nil then
        @relation.where(id: ids)
      else
        @relation
      end
    end
  end

  class CategoryFilter < Filter
    def subset_for_category(tag_id = nil)
      unless tag_id == nil then
        @relation.includes(:tags).where(tags: {id: tag_id})
      else
        @relation
      end
    end
  end

  class DescriptionFilter < Filter
    def subset_for_description_text(text = nil)
      unless text == nil then
        @relation.where('lower(description) LIKE ?', "%#{text.downcase}%")
      else
        @relation
      end
    end
  end
end

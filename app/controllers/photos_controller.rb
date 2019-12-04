class PhotosController < ApplicationController

  def index
    tag_id = params.key?(:category) ? params[:category] : nil
    ids = params.key?(:ids) ? params[:ids] : nil
    page = params.key?(:page) ? params[:page].to_i : 1
    per_page = params.key?(:per_page) ? params[:per_page].to_i : nil
    search_text = params.key?(:searchText) ? params[:searchText] : nil
    puts "SEARCH_TEXT: #{search_text}"

    page = page < 1 ? 1 : page

    id_filtered_photos = PhotosHelper::IdFilter.new(Photo.all)
    category_filtered_photos = PhotosHelper::CategoryFilter.new(id_filtered_photos.subset_for_ids(ids))
    search_text_filtered_photos = PhotosHelper::DescriptionFilter.new(category_filtered_photos.subset_for_category(tag_id))
    photoset = PhotosHelper::Pagination.new(search_text_filtered_photos.subset_for_description_text(search_text)).paginated(page, per_page)


    session[:page] = page
    session[:per_page] = per_page
    session[:pages] = photoset[:pages]

    render json: photoset
  end
end

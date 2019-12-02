class PhotosController < ApplicationController

  def index
    category = params.key?(:category) ? params[:category] : nil
    ids = params.key?(:ids) ? params[:ids] : nil
    page = params.key?(:page) ? params[:page].to_i : 1
    per_page = params.key?(:per_page) ? params[:per_page].to_i : nil

    page = page < 1 ? 1 : page

    id_filtered_photos = PhotosHelper::IdFilter.new(Photo.all)
    category_filtered_photos = PhotosHelper::CategoryFilter.new(id_filtered_photos.subset_for_ids(ids))
    photoset = PhotosHelper::Pagination.new(category_filtered_photos.subset_for_category(category)).paginated(page, per_page)

    session[:page] = page
    session[:per_page] = per_page
    session[:pages] = photoset[:pages]

    render json: photoset
  end
end

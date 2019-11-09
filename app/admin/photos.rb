ActiveAdmin.register Photo do
  permit_params :description, :display_price, :image
  config.per_page = [5, 20, 50]

  index do
    column :description
    column "Price" do |photo|
       raw number_to_currency(photo.display_price)
    end
    column "Image" do |photo|
      link_to (image_tag photo.image.variant(resize: "100x100^")), admin_photo_path(photo)
    end
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :description
      f.input :display_price, as: :string
      f.label :current_image if :image
      f.input :image, as: :file, hint: image_tag(f.object.image.variant(resize: "300x300^"))
    end
    f.actions
  end

  show do
    h3 photo.description
    h2 number_to_currency (photo.display_price)
    div do
      image_tag photo.image.variant(resize: "300x300^")
    end
  end

  controller do
    def create
      params.permit(photo: [:description, :display_price, :image])

      photo = Photo.new
      photo.description = params[:photo][:description]
      photo.value = params[:photo][:display_price].to_f * 100
      photo.image = params[:photo][:image]
      photo.save

      redirect_to admin_photo_path(photo)
    end

    def update
      params.permit(:id, photo: [:description, :display_price, :image])

      photo = Photo.find(params[:id])
      image = photo.image
      new_image = params[:photo][:image]

      photo.description = params[:photo][:description]
      photo.value = params[:photo][:display_price].to_f * 100
      if new_image then
        photo.image = new_image
      end

      photo.save

      redirect_to admin_photo_path(photo)
    end
  end
end

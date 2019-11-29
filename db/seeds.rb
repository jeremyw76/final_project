# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.where(email: 'admin@example.com').first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# province_data = JSON.parse(File.read('db/data/province_seed.json'))

# province_data['provinces'].each do | province |
#   Province.where(name: province['name']).first_or_create(province)
# end

PhotoTag.all.destroy_all
Tag.all.destroy_all

10.times do
  Tag.create(name: Faker::Hipster.word)
end

tag_count = Tag.all.count
Photo.where('id > 8').destroy_all


2.times do |index|
  base_url = "https://api.pexels.com/v1/curated?per_page=55&page=#{index}"
  api_key = Rails.application.credentials.dig(:PEXELS_API_KEY)

  response = RestClient.get(base_url, {'Authorization': api_key})

  photos = JSON.parse(response.body)['photos']

  photos.each do |photo|
    url = photo['src']['medium']
    image_data = RestClient::Request.execute(
      method: :get,
      url: url,
      raw_response: true
    )

    photo = Photo.create(
      description: Faker::Commerce.product_name,
      value: Faker::Commerce.price(range: 20..200),
    )

    photo.image.attach(
      io: image_data.file,
      filename: "photo#{photo.id}.jpg",
      content_type: "image/jpg"
    )

    rand(1...4).times do
      tag = nil
      attempt_count = 0

      while tag.nil? && attempt_count < 3 do
        upper_limit = Tag.last.id + 1
        lower_limit = upper_limit - 11
        tag = Tag.find_by_id(rand(lower_limit..upper_limit))
        attempt_count = attempt_count + 1
      end

      tag = Tag.first if tag.nil?

      photo.tags << tag
    end

    puts "#{photo.id} => Created photo '#{photo.description}'"
  end
end
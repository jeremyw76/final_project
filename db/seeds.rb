# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.where(email: 'admin@example.com').first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

province_data = JSON.parse(File.read('db/data/province_seed.json'))

province_data['provinces'].each do | province |
  Province.where(name: province['name']).first_or_create(province)
end

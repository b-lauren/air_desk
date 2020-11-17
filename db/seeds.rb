require 'open-uri'
require 'json'
require 'faker'

PROPERTY_SPACE_ADJECTIVES = %w[pristine breathtaking detailed spacious bright refreshing one-of-a-kind]
PROPERTY_NEIGHBOURHOOD_ADJECTIVES = %w[inviting prestigious upscale tree-lined historic picturesque safe]

20.times do |i|

  user = User.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'test123456'
  )

  unsplash_url = "https://api.unsplash.com/search/photos/?client_id=#{ENV["UNSPLASH_KEY"]}&per_page=50&query=home%20office"

  file_serialized = URI.open(unsplash_url)
  file = JSON.parse(file_serialized.read)
  photo = URI.open(file['results'][i]['urls']['regular'])

  listing = Listing.new(
    title: "#{PROPERTY_SPACE_ADJECTIVES.sample.capitalize} space in #{PROPERTY_NEIGHBOURHOOD_ADJECTIVES.sample} neighborhood",
    description: 'Placeholder description',
    available: true,
    rate: Faker::Number.between(from: 60, to: 2000),
    address_line_1: Faker::Address.street_address,
    address_line_2: Faker::Address.secondary_address,
    postcode: Faker::Address.postcode,
    city: Faker::Address.city
  )

  listing.user = user
  listing.photos.attach(io: photo, filename: 'unsplash.jpg', content_type: 'image/jpg')
  listing.save!
end

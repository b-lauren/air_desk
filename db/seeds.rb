require 'open-uri'
require 'json'

# user = User.create(
#   email: 'john@test.com',
#   first_name: 'John',
#   last_name: 'Joubert',
#   password: 'test123456'
# )

user = User.first

unsplash_url = "https://api.unsplash.com/search/photos/?client_id=#{ENV["UNSPLASH_KEY"]}&per_page=50&query=home%20office"

file_serialized = URI.open(unsplash_url)
file = JSON.parse(file_serialized.read)
photo = URI.open(file['results'][0]['urls']['regular'])

listing = Listing.new(
  description: 'Some description',
  title: 'Some title',
  available: true,
  rate: 50,
  address_line_1: 'My address',
  address_line_2: 'My address',
  postcode: 'My address',
  city: 'My address'
)

listing.user = user
listing.photos.attach(io: photo, filename: 'unsplash.jpg', content_type: 'image/jpg')
listing.save!

require 'open-uri'
require 'json'
require 'faker'

SPACE_ADJECTIVES = %w[pristine breathtaking detailed spacious bright refreshing one-of-a-kind]
NEIGHBOURHOOD_ADJECTIVES = %w[inviting prestigious upscale beautiful historic picturesque safe]
HOME_SYNONYMS = %w[home room building study house manor castle bedroom lounge]

ADDRESSES = ["Oxford street, London", "Finsbury Park, London", "London Bridge", "Regent Street, London", "Bond Street, London", "Baker Street, London", "Shoreditch, London", "Lodge Road, London", "Wellington Road, London", "Hollycroft Avenue, London", "Brent Street, London", "Woodfield Avenue, London", "Gresham Road, London" ]

puts 'Starting seed file...'

puts 'Clearing Bookings....'

Booking.destroy_all

puts 'Bookings destroyed....'

puts 'Clearing Listings....'

Listing.destroy_all

puts 'Listings destroyed....'

puts 'Clearing Users...'

User.destroy_all

puts 'Users destroyed....'

puts 'Creating new users, listings and bookings...'

unsplash_url = "https://api.unsplash.com/search/photos/?client_id=#{ENV["UNSPLASH_KEY"]}&per_page=50&query=home%20desk"

file_serialized = URI.open(unsplash_url)
file = JSON.parse(file_serialized.read)

25.times do |i|

  user = User.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'test123456'
  )

  puts "Created User: #{user.first_name} (id: #{user.id})"


  photo = URI.open(file['results'][i]['urls']['regular'])

  space_adjective = SPACE_ADJECTIVES.sample
  neighbourhood_adjective = NEIGHBOURHOOD_ADJECTIVES.sample
  home_synonym = HOME_SYNONYMS.sample


  listing = Listing.new(
    title: "#{space_adjective.capitalize} space in #{neighbourhood_adjective} #{home_synonym}",
    description: "This #{space_adjective} space is ideal for someone looking to spend the day working productively. You'll love spending time in this #{neighbourhood_adjective} #{home_synonym}, where a you'll be provided with a desk, chair and free coffee and tea. Book now to avoid dissapointment.",
    available: true,
    rate: Faker::Number.between(from: 5, to: 65),
    address_line_1: ADDRESSES.sample,
    address_line_2: Faker::Address.secondary_address,
    postcode: Faker::Address.postcode,
    city: Faker::Address.city
  )

  listing.user = user
  listing.photos.attach(io: photo, filename: 'unsplash.jpg', content_type: 'image/jpg')
  listing.save!

  puts "Created Listing: #{listing.title} (id: #{listing.id})"

  booking_date = Faker::Date.forward(days: 23)
  booking = Booking.new(
    start_date: booking_date,
    end_date: booking_date + rand(1..10)
  )
  booking.user = User.offset(rand(User.count)).first
  booking.listing = listing
  booking.save

  puts "Created Booking for Listing: #{listing.title} (Booking id: #{booking.id})"
end

puts "Finished."
puts "Created #{User.count} Users"
puts "Created #{Listing.count} Listings"
puts "Created #{Booking.count} Bookings"

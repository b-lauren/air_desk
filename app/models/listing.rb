class Listing < ApplicationRecord
  has_many_attached :photos
  validates :description, :title, :rate, :photos, presence: true
  belongs_to :user
  has_many :bookings
  geocoded_by :address_line_1
  after_validation :geocode, if: :will_save_change_to_address_line_1?

   include PgSearch::Model
  pg_search_scope :search_listings,
    against: [ :title, :description, :address_line_1 ],
    using: {
      tsearch: { prefix: true }
    }
end

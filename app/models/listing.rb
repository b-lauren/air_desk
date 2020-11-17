class Listing < ApplicationRecord
  has_many_attached :photos
  validates :description, :title, :rate, presence: true
  belongs_to :user
  has_many :bookings
end

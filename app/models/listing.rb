class Listing < ApplicationRecord
  has_many_attached :photos
  validates :location, :description, :title, :price, presence: true
end

class Listing < ApplicationRecord
  has_many_attached :photos
  validates :description, :title, :price, presence: true
end

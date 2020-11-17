class RemoveLocationFromListings < ActiveRecord::Migration[6.0]
  def change
    remove_column :listings, :location, :string
  end
end

class AddAdressToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :address_line_1, :string
    add_column :listings, :address_line_2, :string
    add_column :listings, :postcode, :string
    add_column :listings, :city, :string
  end
end

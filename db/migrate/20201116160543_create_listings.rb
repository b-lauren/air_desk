class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.text :description
      t.string :title
      t.string :location
      t.boolean :available
      t.integer :rate

      t.timestamps
    end
  end
end

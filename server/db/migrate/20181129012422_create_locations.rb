class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'cube'
    enable_extension 'earthdistance'

    create_table :locations, id: :uuid do |t|
      t.string :name, null: false
      t.string :handle, null: false
      t.point :latlng, null: false

      t.timestamps
    end

    add_index :locations, :handle, unique: true
  end
end

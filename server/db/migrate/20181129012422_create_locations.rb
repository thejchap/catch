class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'cube'
    enable_extension 'earthdistance'

    create_table :locations, id: :uuid do |t|
      t.string :name
      t.string :handle
      t.point :latlng

      t.timestamps
    end
  end
end

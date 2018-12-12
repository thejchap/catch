# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Location.delete_all
User.delete_all
Availability.delete_all

location_attrs = [{
  handle: 'earth-treks-rockville',
  name: 'Earth Treks - Rockville',
  latlng: [39.0787031,-77.1436384]
}, {
  handle: 'earth-treks-crystal-city',
  name: 'Earth Treks - Crystal City',
  latlng: [38.8615758,-77.0529378]
}]

locations = Location.create! location_attrs
location_ids = locations.map(&:id)

500.times do |n|
  User.create!(
    facebook_id: SecureRandom.hex,
    facebook_data: {
      first_name: "Test #{n}",
      last_name: "User",
      email: "test-#{n}@example.com"
    },
    settings_location: location_ids.sample,
    settings_activities: [rand(1..4)]
  )
end

User.find_in_batches do |users|
  users.each do |user|
    attrs = [{
      range: 90..120,
      user_id: user.id,
      day: 1
    }, {
      range: 90..120,
      user_id: user.id,
      day: 3
    }, {
      range: 90..120,
      user_id: user.id,
      day: 5
    }]

    Availability.create! attrs
  end
end

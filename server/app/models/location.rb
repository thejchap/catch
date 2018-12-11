# == Schema Information
#
# Table name: locations
#
#  id         :uuid             not null, primary key
#  name       :string
#  handle     :string
#  latlng     :point
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Earth Treks - Rockville: 39.0787031,-77.1436384
# Earth Treks - Crystal City: 38.8615758,-77.0529378

class Location < ApplicationRecord
  include IdentityCache

  def lat
    latlng&.x
  end

  def lng
    latlng&.y
  end
end

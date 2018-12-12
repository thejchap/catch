# frozen_string_literal: true

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

class Location < ApplicationRecord
  include IdentityCache

  def lat
    latlng&.x
  end

  def lng
    latlng&.y
  end
end

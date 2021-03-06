# frozen_string_literal: true

# == Schema Information
#
# Table name: availabilities
#
#  id         :uuid             not null, primary key
#  day        :integer          not null
#  range      :int4range        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#

class Availability < ApplicationRecord
  include IdentityCache

  validates :day, presence: true
  validates :range, presence: true
  belongs_to :user
  scope :at_location, (lambda do |location_id|
    joins(:user).where(
      'users.settings->>\'location\' = ?',
      location_id
    )
  end)

  cache_index :user_id

  def starts_at
    range.begin
  end

  def ends_at
    range.end
  end
end

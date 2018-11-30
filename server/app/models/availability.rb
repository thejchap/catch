# == Schema Information
#
# Table name: availabilities
#
#  id         :uuid             not null, primary key
#  day        :integer          not null
#  range      :int4range        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Availability < ApplicationRecord
  enum day: Wday::ALL
  validates :day, presence: true
  validates :range, presence: true
end

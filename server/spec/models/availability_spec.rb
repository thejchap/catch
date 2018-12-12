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

require 'rails_helper'

RSpec.describe Availability, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

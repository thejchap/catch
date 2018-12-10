# == Schema Information
#
# Table name: users
#
#  id            :uuid             not null, primary key
#  facebook_id   :string           not null
#  facebook_data :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  settings      :jsonb
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: users
#
#  id            :uuid             not null, primary key
#  facebook_id   :string           not null
#  facebook_data :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ApplicationRecord
  include IdentityCache

  cache_index :facebook_id, unique: true

  has_many :access_tokens,
    class_name: 'Doorkeeper::AccessToken',
    foreign_key: :resource_owner_id,
    dependent: :delete_all

  jsonb_accessor :facebook_data,
    email: :string,
    first_name: :string,
    last_name: :string,
    picture: :json

  def picture_url
    picture.dig 'data', 'url'
  end
end

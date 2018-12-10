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

class User < ApplicationRecord
  include IdentityCache

  cache_index :facebook_id, unique: true

  has_many :availabilities

  has_many :access_tokens,
    class_name: 'Doorkeeper::AccessToken',
    foreign_key: :resource_owner_id,
    dependent: :delete_all

  jsonb_accessor :facebook_data,
    email: :string,
    first_name: :string,
    last_name: :string,
    picture: :json

  jsonb_accessor :settings,
    settings_activities_bouldering: [:boolean, store_key: :'activities.bouldering'],
    settings_activities_lead:       [:boolean, store_key: :'activities.lead'],
    settings_activities_top_rope:   [:boolean, store_key: :'activities.top_rope'],
    settings_activities_workout:    [:boolean, store_key: :'activities.workout'],
    settings_location:              [:string,  store_key: :location]

  def picture_url
    picture&.dig 'data', 'url'
  end
end

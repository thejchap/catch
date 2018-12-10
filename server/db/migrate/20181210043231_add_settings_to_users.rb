class AddSettingsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :settings, :jsonb, default: '{}'

    reversible do |dir|
      dir.up do
        User.update_all settings: {}
      end
    end
  end
end

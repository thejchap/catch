class AddLocationIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :settings, using: :gin
    add_index :users, '(settings->>\'location\'::text)'
  end
end

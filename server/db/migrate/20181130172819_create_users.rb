class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :facebook_id, null: false
      t.jsonb :facebook_data, default: '{}'

      t.timestamps
    end

    add_index :users, :facebook_id, unique: true
  end
end

class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities, id: :uuid do |t|
      t.integer :day, limit: 1, null: false
      t.int4range :range, null: false

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute 'ALTER TABLE availabilities ADD CONSTRAINT day_gte_0 CHECK (day >= 0);'
        execute 'ALTER TABLE availabilities ADD CONSTRAINT day_lte_6 CHECK (day <= 6);'
      end

      dir.down do
        execute 'ALTER TABLE availabilities DROP CONSTRAINT day_gte_0;'
        execute 'ALTER TABLE availabilities DROP CONSTRAINT day_lte_6;'
      end
    end
  end
end

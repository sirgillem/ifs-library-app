class CreatePartInstruments < ActiveRecord::Migration
  def change
    create_table :part_instruments do |t|
      t.references :part, index: true, foreign_key: true
      t.references :instrument, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

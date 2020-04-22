class CreatePartInstruments < ActiveRecord::Migration
  def change
    create_table :part_instruments do |t|
      t.references :song_part, index: true, null: false
      t.references :instrument, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :part_instruments, :song_parts
    add_foreign_key :part_instruments, :instruments
  end
end

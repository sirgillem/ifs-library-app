class CreatePartInstruments < ActiveRecord::Migration
  def change
    create_table :part_instruments do |t|
      t.references :part, index: true, null: false
      t.references :instrument, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :part_instruments, :parts
    add_foreign_key :part_instruments, :instruments
  end
end

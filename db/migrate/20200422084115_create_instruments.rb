class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.text :name
      t.references :instrument_section, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

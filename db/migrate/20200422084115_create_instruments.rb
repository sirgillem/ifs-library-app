class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.text :name, null: false
      t.references :section, index: true

      t.timestamps null: false
    end
    add_foreign_key :instruments, :instrument_sections, column: :section_id
  end
end

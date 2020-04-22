class CreateInstrumentSections < ActiveRecord::Migration
  def change
    create_table :instrument_sections do |t|
      t.string :name, null: false
      t.integer :sequence, null: false

      t.timestamps null: false
    end
  end
end

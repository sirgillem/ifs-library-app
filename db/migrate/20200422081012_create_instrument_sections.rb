class CreateInstrumentSections < ActiveRecord::Migration
  def change
    create_table :instrument_sections do |t|
      t.string :name
      t.integer :sequence

      t.timestamps null: false
    end
  end
end

class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :name
      t.references :publisher, index: true, foreign_key: true
      t.string :serial

      t.timestamps null: false
    end
  end
end

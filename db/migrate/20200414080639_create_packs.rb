class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :name, null: false
      t.references :publisher, index: true, null: false
      t.string :serial

      t.timestamps null: false
    end
    add_foreign_key :packs, :publishers
  end
end

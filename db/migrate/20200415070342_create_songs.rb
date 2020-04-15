class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :label
      t.references :publisher, index: true
      t.string :serial
      t.text :details
      t.text :notes_perf
      t.text :notes_lib
      t.references :pack, index: true
      t.string :recording
      t.string :style
      t.integer :duration
      t.integer :tempo
      t.date :purchased_at

      t.timestamps null: false
    end
    add_index :songs, :title
    add_index :songs, :label
    add_foreign_key :songs, :publishers
    add_foreign_key :songs, :packs
  end
end

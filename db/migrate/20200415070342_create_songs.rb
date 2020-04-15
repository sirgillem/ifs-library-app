class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :label
      t.references :publisher, index: true, foreign_key: true
      t.string :serial
      t.text :details
      t.text :notes_perf
      t.text :notes_lib
      t.references :pack, index: true, foreign_key: true
      t.string :recording
      t.string :style
      t.int :duration
      t.int :tempo
      t.date :purchased_at

      t.timestamps null: false
    end
    add_index :songs, :title
    add_index :songs, :label
  end
end

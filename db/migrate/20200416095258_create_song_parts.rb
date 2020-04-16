class CreateSongParts < ActiveRecord::Migration
  def change
    create_table :song_parts do |t|
      t.references :song, index: true, foreign_key: true
      t.string :name
      t.boolean :scanned
      t.text :notes
      t.references :template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

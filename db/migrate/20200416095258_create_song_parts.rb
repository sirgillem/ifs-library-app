class CreateSongParts < ActiveRecord::Migration
  def change
    create_table :song_parts do |t|
      t.references :song, index: true
      t.string :name
      t.boolean :scanned
      t.text :notes
      t.references :template, index: true

      t.timestamps null: false
    end
    add_foreign_key :song_parts, :songs
    add_foreign_key :song_parts, :song_templates
  end
end

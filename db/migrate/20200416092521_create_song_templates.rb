class CreateSongTemplates < ActiveRecord::Migration
  def change
    create_table :song_templates do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

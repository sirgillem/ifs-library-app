class AddSequenceToSongParts < ActiveRecord::Migration
  def change
    add_column :song_parts, :sequence, :integer, null: false, default: 0
  end
end

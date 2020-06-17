class RemovePurchasedAtFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :purchased_at, :date
  end
end

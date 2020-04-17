# Add index for commonly used fields in the people table
class AddIndicesToPeople < ActiveRecord::Migration
  def change
    add_index :people, :key_name
    add_index :people, :pre_names
  end
end

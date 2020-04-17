class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :pre_titles
      t.string :pre_names
      t.string :key_name_prefix
      t.string :key_name, null: false
      t.string :post_names
      t.string :key_name_suffix
      t.string :qualifications
      t.string :post_titles

      t.timestamps null: false
    end
  end
end

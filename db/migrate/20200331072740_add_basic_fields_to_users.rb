class AddBasicFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :librarian, :boolean, null: false, default: false
  end
end

class CreateContributorRelations < ActiveRecord::Migration
  def change
    create_table :contributor_relations do |t|
      t.references :contributable, polymorphic: true, index: true
      t.references :person, index: true
      t.string :role
      t.integer :sequence

      t.timestamps null: false
    end
    add_foreign_key :contributor_relations, :people
end

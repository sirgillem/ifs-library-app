class CreateContributorRelations < ActiveRecord::Migration
  def change
    create_table :contributor_relations do |t|
      t.references :contributable, polymorphic: true,
                                   index: { name: :index_library_contributor_relations_on_contributable }
      t.references :person, index: true
      t.string :role
      t.integer :sequence, null: false

      t.timestamps null: false
    end
    add_foreign_key :contributor_relations, :people
  end
end

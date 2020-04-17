module Contributable
  extend ActiveSupport::Concern

  included do
    has_many :contributor_relations, as: :contributable, dependent: :destroy
  end

  # Add a contributor
  def add_contributor(person, role)
    max_seq = contributor_relations.last.sequence
    rel = ContributorRelation.new(contributable: self,
                                  person: person,
                                  role: role,
                                  sequence: max_seq + 1)
    contributor_relations << rel
  end

  # Remove all contribution relationships for a person
  def remove_contributor(person)
    contributor_relations.each do |rel|
      contributor_relations.delete(rel) if rel.person == person
    end
  end
end

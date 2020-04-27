module Contributable
  extend ActiveSupport::Concern

  included do
    has_many :contributor_relations, as: :contributable, dependent: :destroy
    accepts_nested_attributes_for :contributor_relations,
                                  allow_destroy: true,
                                  reject_if: :all_blank
  end

  # Convert contributor list to attribution strings
  def attributions
    attribs = {}
    contributor_relations.each do |rel|
      role = rel.role.to_sym
      if attribs[role]
        attribs[role] << rel.person.full_name
      else
        attribs[role] = [rel.person.full_name]
      end
    end
    output = []
    attribs.each do |role, people|
      output << "#{role} by #{people.to_sentence}"
    end
    return output
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

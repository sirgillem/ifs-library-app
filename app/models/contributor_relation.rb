class ContributorRelation < ActiveRecord::Base
  default_scope -> { order(:sequence) }
  belongs_to :contributable, polymorphic: true
  belongs_to :person

  # Get a descriptive string for the relationship
  def full_text
    "#{role} by #{person.full_name}"
  end
end

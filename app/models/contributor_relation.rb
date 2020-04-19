class ContributorRelation < ActiveRecord::Base
  default_scope -> { order(:sequence) }
  belongs_to :contributable, polymorphic: true
  belongs_to :person, required: true
  validates :sequence, numericality: { greater_than_or_equal_to: 0 }
  accepts_nested_attributes_for :person,
                                reject_if: :all_blank

  # Get a descriptive string for the relationship
  def full_text
    "#{role} by #{person.full_name}"
  end
end

class ContributorRelation < ActiveRecord::Base
  belongs_to :contributable, polymorphic: true
  belongs_to :person
end

module ContributableController
  extend ActiveSupport::Concern

  def contributable_params
    [contributor_relations_attributes: [:id, :person_id, :role, :sequence, :_destroy]]
  end
end

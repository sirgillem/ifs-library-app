module Contributable
  extend ActiveSupport::Concern

  included do
    has_many :contributor_relations, as: :contributable
  end
end

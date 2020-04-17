module Contributable
  extend ActiveSupport::Concern

  included do
    has_many :contributor_relations, as: :contributable, dependent: :destroy
  end
end

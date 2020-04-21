class Pack < ActiveRecord::Base
  include Contributable
  belongs_to :publisher, required: true
  has_many :songs, dependent: :nullify
  accepts_nested_attributes_for :publisher, reject_if: :all_blank
  validates :name, presence: true

  def to_s
    name
  end
end

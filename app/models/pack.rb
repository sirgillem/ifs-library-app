class Pack < ActiveRecord::Base
  belongs_to :publisher, required: true
  validates :name, presence: true
end

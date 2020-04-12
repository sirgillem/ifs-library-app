# Record information on publishers
class Publisher < ActiveRecord::Base
  validates :name, presence: true
end

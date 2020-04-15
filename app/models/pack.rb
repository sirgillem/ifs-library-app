class Pack < ActiveRecord::Base
  belongs_to :publisher, required: true
  has_many :songs
  validates :name, presence: true
end

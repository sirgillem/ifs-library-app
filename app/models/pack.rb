class Pack < ActiveRecord::Base
  belongs_to :publisher, required: true
  has_many :songs
  validates :name, presence: true

  def to_s
    name
  end
end

class Pack < ActiveRecord::Base
  belongs_to :publisher, required: true
  has_many :songs, dependent: :nullify
  validates :name, presence: true

  def to_s
    name
  end
end

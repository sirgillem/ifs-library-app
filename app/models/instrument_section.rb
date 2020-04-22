class InstrumentSection < ActiveRecord::Base
  has_many :instruments,
           inverse_of: :section,
           foreign_key: 'section_id',
           dependent: :destroy
  validates :name, presence: true
  validates :sequence, numericality: { greater_than_or_equal_to: 0 }

  def to_s
    name
  end
end

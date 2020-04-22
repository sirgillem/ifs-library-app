class InstrumentSection < ActiveRecord::Base
  validates :name, presence: true
  validates :sequence, numericality: { greater_than_or_equal_to: 0 }

  def to_s
    name
  end
end

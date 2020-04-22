class Instrument < ActiveRecord::Base
  belongs_to :section, class_name: InstrumentSection
  has_many :song_parts, through: :part_instruments
  validates :name, presence: true

  def to_s
    name
  end
end

class Instrument < ActiveRecord::Base
  belongs_to :section, class_name: InstrumentSection
  validates :name, presence: true

  def to_s
    name
  end
end

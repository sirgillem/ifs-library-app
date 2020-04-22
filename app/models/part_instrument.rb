class PartInstrument < ActiveRecord::Base
  belongs_to :song_part, required: true
  belongs_to :instrument, required: true
end

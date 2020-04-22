class PartInstrument < ActiveRecord::Base
  belongs_to :part
  belongs_to :instrument
end

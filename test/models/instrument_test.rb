require 'test_helper'

class InstrumentTest < ActiveSupport::TestCase
  test 'instrument must have a name' do
    i = Instrument.new(name: '   ', section_id: instrument_sections(:sax).id)
    assert_not i.valid?
    i.name = 'foobar'
    assert i.valid?
  end
end

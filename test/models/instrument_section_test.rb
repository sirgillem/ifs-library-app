require 'test_helper'

class InstrumentSectionTest < ActiveSupport::TestCase
  test 'Section must have a name' do
    s = InstrumentSection.new(name: '  ', sequence: 0)
    assert_not s.valid?
    s.name = 'Crowd'
    assert s.valid?
  end

  test 'Section must have a sequence number' do
    s = InstrumentSection.new(name: 'test', sequence: nil)
    assert_not s.valid?
    s.sequence = -1
    assert_not s.valid?
    s.sequence = 0
    assert s.valid?
    s.sequence = 1234
    assert s.valid?
  end
end

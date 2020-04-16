require 'test_helper'

class SongTemplateTest < ActiveSupport::TestCase
  test 'must have a name' do
    t = SongTemplate.new(name: '    ')
    assert_not t.valid?
    t.name = 'Template'
    assert t.valid?
  end
end

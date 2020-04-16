require 'test_helper'

class SongPartTest < ActiveSupport::TestCase
  test 'song part must have a name' do
    p = song_parts(:opus_one_tenor1)
    p.name = '    '
    assert_not p.valid?
    p.name = 'Tenor 1'
    assert p.valid?
  end

  test 'song part must belong to a song xor template' do
    p = song_parts(:opus_one_tenor1)
    assert p.valid?
    p.song = nil
    assert_not p.valid?
    p.song_template = song_templates(:bigband)
    assert p.valid?
    p.song = songs(:opus_one)
    assert_not p.valid?
  end
end

require 'test_helper'

class SongTest < ActiveSupport::TestCase
  def setup
    @song = songs(:opus_one)
  end

  test 'Song must have publisher or pack' do
    assert @song.valid?
    @song.publisher = nil
    assert @song.valid?
    @song.pack = packs(:easy_pack_1)
    assert @song.valid?
    @song.publisher = publishers(:pub1)
    assert_not @song.valid?
  end

  test 'Song must have a title' do
    assert @song.valid?
    @song.title = '    '
    assert_not @song.valid?
  end

  test 'Song tempo must be positive if it exists' do
    @song.tempo = nil
    assert @song.valid?
    @song.tempo = -1
    assert_not @song.valid?
    @song.tempo = 1
    assert @song.valid?
  end

  test 'Song duration must be positive if it exists' do
    @song.duration = nil
    assert @song.valid?
    @song.duration = -1
    assert_not @song.valid?
    @song.duration = 1
    assert @song.valid?
  end
end

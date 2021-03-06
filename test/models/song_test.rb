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

  test 'Can add contributors' do
    john = people(:johndoe)
    @song.add_contributor(john, 'Tested')
    assert_equal @song.contributor_relations.last.person, john
    assert_equal @song.contributor_relations.last.role, 'Tested'
    assert @song.contributor_relations.last.valid?
  end

  test 'Can remove contributors' do
    john = people(:johndoe)
    @song.remove_contributor(john)
    @song.contributor_relations.each do |rel|
      assert_not_equal rel.person, john
    end
  end

  test 'Duration can be formatted as a string' do
    @song.duration = 9
    assert_equal '0:09', @song.duration_string
    @song.duration = 3599
    assert_equal '59:59', @song.duration_string
    @song.duration = 10 * 3600 + 2 * 60 + 1
    assert_equal '10:02:01', @song.duration_string
    assert_equal '', Song.new.duration_string
  end

  test 'Attributions appear correctly' do
    attribs = @song.attributions
    assert_match 'Words', attribs[0]
    assert_match people(:harry).full_name, attribs[0]
    assert_match people(:bjork).full_name, attribs[0]
    assert_match people(:johndoe).full_name, attribs[0]
    assert_match 'Music', attribs[1]
    assert_match people(:beethoven).full_name, attribs[1]
  end
end

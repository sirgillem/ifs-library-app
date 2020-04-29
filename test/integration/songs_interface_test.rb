require 'test_helper'

class SongsInterfaceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'Can create a song with all valid sub-fields' do
    # Ensure count of various models changes
    init_songs_count = Song.count
    init_contribs_count = ContributorRelation.count
    init_people_count = Person.count
    init_publisher_count = Publisher.count
    init_part_count = SongPart.count
    init_part_instruments_count = PartInstrument.count

    sign_in users(:librarian)
    get new_song_path
    assert_response :success
    publisher_params = { name: "Goodwin's Goodies",
                         website: 'www.example.com' }
    new_person_params = { pre_names: 'Johann Sebasitan',
                          key_name: 'Bach' }
    contributor_params = { '0' => { person_id: people(:johndoe).id,
                                    role: 'Written and arranged',
                                    sequence: 0 },
                           '1' => { person_attributes: new_person_params,
                                    role: 'Adapted',
                                    sequence: 1 } }
    part_params = { '0' => { name: 'Alto 1',
                             scanned: false,
                             notes: 'Solo bars 32-64',
                             part_instruments_attributes: {
                               '0' => {
                                 instrument_id: Instrument.first.id
                               },
                               '1' => {
                                 instrument_id: Instrument.last.id
                               }
                             },
                             sequence: 0 },
                    '1' => { name: 'Alto 2',
                             sequence: 1 } }
    song_params = { title: 'Running to the Bridge',
                    label: '226',
                    publisher_attributes: publisher_params,
                    contributor_relations_attributes: contributor_params,
                    song_parts_attributes: part_params,
                    serial: '1234',
                    details: "as recorded on the album 'That's How We Roll'",
                    performance_notes: 'Solos alto 1x, tenor 2x',
                    librarian_notes: 'Multiple copies',
                    recording: 'www.youtube.com',
                    style: 'Bebop',
                    duration: 372,
                    tempo: 300,
                    purchased_at: Date.today }
    post songs_path, song: song_params
    assert_equal init_songs_count + 1, Song.count
    assert_equal init_contribs_count + 2, ContributorRelation.count
    assert_equal init_people_count + 1, Person.count
    assert_equal init_publisher_count + 1, Publisher.count
    assert_equal init_part_count + 2, SongPart.count
    assert_equal init_part_instruments_count + 2, PartInstrument.count
    follow_redirect!
    assert_template 'songs/show'
  end

  test 'can filter songs by title' do
    sign_in users(:limited_admin)
    get songs_path, title: 'opus'
    assert assigns(:songs).include?(songs(:opus_one))
    assert_not assigns(:songs).include?(songs(:jingle_bells))
  end

  test 'can filter songs by label' do
    sign_in users(:limited_admin)
    get songs_path, label: '1'
    assert assigns(:songs).include?(songs(:opus_one))
    assert_not assigns(:songs).include?(songs(:old_song))
  end

  test 'can filter songs by serial' do
    sign_in users(:limited_admin)
    get songs_path, serial: '78'
    assert assigns(:songs).include?(songs(:night_and_day_hkm))
    assert_not assigns(:songs).include?(songs(:opus_one))
  end

  test 'can filter songs by style' do
    sign_in users(:limited_admin)
    get songs_path, style: 'swing'
    assert assigns(:songs).include?(songs(:opus_one))
    assert_not assigns(:songs).include?(songs(:old_song))
  end

  test 'can filter songs by tempo' do
    sign_in users(:limited_admin)
    get songs_path, min_tempo: 138, max_tempo: 150
    assert assigns(:songs).include?(songs(:night_and_day_lkf))
    assert assigns(:songs).include?(songs(:opus_one))
    assert_not assigns(:songs).include?(songs(:jingle_bells))
    assert_not assigns(:songs).include?(songs(:old_song))
  end

  test 'can filter songs by duration' do
    sign_in users(:limited_admin)
    get songs_path, min_dur: '3:20', max_dur: '4:00'
    assert assigns(:songs).include?(songs(:night_and_day_lkf))
    assert_not assigns(:songs).include?(songs(:jingle_bells))
    assert_not assigns(:songs).include?(songs(:opus_one))
  end

  test 'can filter songs by instrument' do
    sign_in users(:limited_admin)
    get songs_path, instrument: 'clarinet'
    assert assigns(:songs).include?(songs(:old_song))
    assert_not assigns(:songs).include?(songs(:jingle_bells))
  end

  test 'blank filters act as no filtering' do
    sign_in users(:limited_admin)
    get songs_path,
        title: '',
        serial: '',
        style: '',
        min_dur: '',
        max_dur: '',
        min_tempo: '',
        max_tempo: '',
        instrument: ''
    assert_equal Song.all.count, assigns(:songs).size
  end
end

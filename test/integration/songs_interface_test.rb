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
    follow_redirect!
    assert_template 'songs/show'
  end
end

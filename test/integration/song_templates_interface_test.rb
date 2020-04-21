require 'test_helper'

class SongTemplatesInterfaceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'Can create a song template with all valid sub-fields' do
    # Ensure count of various models changes
    init_song_templates_count = SongTemplate.count
    init_part_count = SongPart.count

    sign_in users(:librarian)
    get new_song_template_path
    assert_response :success
    part_params = { '0' => { name: 'Alto 1',
                             scanned: false,
                             notes: 'Solo bars 32-64',
                             sequence: 0 },
                    '1' => { name: 'Alto 2',
                             sequence: 1 } }
    tmpl_params = { name: 'Foobar',
                    song_parts_attributes: part_params }
    post song_templates_path, song_template: tmpl_params
    assert_equal init_song_templates_count + 1, SongTemplate.count
    assert_equal init_part_count + 2, SongPart.count
    follow_redirect!
    assert_template 'song_templates/show'
  end
end

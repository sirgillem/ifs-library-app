require 'test_helper'

class PacksInterfaceTestTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'Can create a pack with all valid sub-fields' do
    # Ensure count of various models changes
    init_packs_count = Pack.count
    init_contribs_count = ContributorRelation.count
    init_people_count = Person.count

    sign_in users(:librarian)
    get new_pack_path
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
    pack_params = { name: 'Easy Jazz Pack #5',
                    publisher_id: publishers(:pub1).id,
                    contributor_relations_attributes: contributor_params,
                    serial: '1234' }
    post packs_path, pack: pack_params
    assert_equal init_packs_count + 1, Pack.count
    assert_equal init_contribs_count + 2, ContributorRelation.count
    assert_equal init_people_count + 1, Person.count
    follow_redirect!
    assert_template 'packs/show'
  end
end

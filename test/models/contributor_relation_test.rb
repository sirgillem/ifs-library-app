require 'test_helper'

class ContributorRelationTest < ActiveSupport::TestCase
  test 'relations are returned in sequence' do
    song = Song.create(title: 'Test Song')
    c1 = ContributorRelation.create(contributable: song,
                                    person: people(:johndoe),
                                    role: 'Words and Music',
                                    sequence: 10)
    c2 = ContributorRelation.create(contributable: song,
                                    person: people(:complexname),
                                    role: 'Sponsored',
                                    sequence: 5)
    contribs = song.contributor_relations
    assert_equal c2, contribs[0]
    assert_equal c1, contribs[1]
  end

  test 'relation display name has role and person' do
    contrib = contributor_relations(:one)
    assert_match contrib.role, contrib.full_text
    assert_match contrib.person.key_name, contrib.full_text
  end
end

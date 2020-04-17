require 'test_helper'

class PackTest < ActiveSupport::TestCase
  def setup
    @pack = packs(:easy_pack_1)
  end

  test 'Pack needs a name' do
    new_pack = Pack.new(name: '    ', publisher: Publisher.first, serial: '1')
    assert_not new_pack.valid?
  end

  test "Pack doesn't need a serial number" do
    new_pack = Pack.new(name: 'New', publisher: Publisher.first)
    assert new_pack.valid?
  end

  test 'Pack needs a valid publisher' do
    new_pack = Pack.new(name: 'New')
    assert_not new_pack.valid?
  end

  test 'Valid pack can be created with all fields' do
    new_pack = Pack.new(name: 'New', publisher: Publisher.first, serial: 'XY')
    assert new_pack.valid?
  end

  test 'Can add contributors' do
    john = people(:johndoe)
    @pack.add_contributor(john, 'Tested')
    assert_equal @pack.contributor_relations.last.person, john
    assert_equal @pack.contributor_relations.last.role, 'Tested'
    assert @pack.contributor_relations.last.valid?
  end

  test 'Can remove contributors' do
    john = people(:johndoe)
    @pack.remove_contributor(john)
    @pack.contributor_relations.each do |rel|
      assert_not_equal rel.person, john
    end
  end
end

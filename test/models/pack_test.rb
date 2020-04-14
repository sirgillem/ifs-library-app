require 'test_helper'

class PackTest < ActiveSupport::TestCase
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
end

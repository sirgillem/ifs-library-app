require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  test 'Publisher needs a name' do
    new_pub = Publisher.new(name: '  ', website: 'www.example.com')
    assert_not new_pub.valid?
  end

  test "Publisher doesn't need a website" do
    new_pub = Publisher.new(name: 'Foo productions', website: '')
    assert new_pub.valid?
  end
end

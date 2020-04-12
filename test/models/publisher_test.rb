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

  test 'Full URL is calculated if no protocol header' do
    new_pub = Publisher.new(name: '1', website: 'www.example.com')
    assert_equal 'http://www.example.com', new_pub.full_url
  end

  test 'Full URL handles protocol header in database' do
    url = 'https://www.example.com'
    new_pub = Publisher.new(name: '2', website: url)
    assert_equal url, new_pub.full_url
  end
end

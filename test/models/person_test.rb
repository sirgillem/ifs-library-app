require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'Person must have a key name' do
    p = Person.new(key_name: '    ')
    assert_not p.valid?
    p.key_name = 'Bob'
    assert p.valid?
  end

  test 'All fields of a name are included in full name in order' do
    p = Person.new(pre_titles: 'A',
                   pre_names: 'B',
                   key_name_prefix: 'C',
                   key_name: 'D',
                   post_names: 'E',
                   key_name_suffix: 'F',
                   qualifications: 'G',
                   post_titles: 'H')
    assert_equal 'A B C D E F G H', p.full_name
  end

  test 'All fields of a name are included in sort name in correct order' do
    p = Person.new(pre_titles: '5',
                   pre_names: '2',
                   key_name_prefix: '3',
                   key_name: '1',
                   post_names: '4',
                   key_name_suffix: '6',
                   qualifications: '7',
                   post_titles: '8')
    assert_equal '1, 2, 3, 4, 5, 6, 7, 8', p.sort_name
  end

  test 'full name ignores nil fields' do
    p = Person.new(pre_names: 'John',
                   key_name: 'Doe',
                   qualifications: 'PhD')
    assert_equal 'John Doe PhD', p.full_name
  end

  test 'sort name ignores nil fields' do
    p = Person.new(pre_names: 'John',
                   key_name: 'Doe',
                   qualifications: 'PhD')
    assert_equal 'Doe, John, PhD', p.sort_name
  end
end

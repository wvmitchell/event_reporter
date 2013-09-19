require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/queue'
require './lib/attendee'
require './lib/phone_number'
require './lib/zipcode'

class QueueTest < MiniTest::Unit::TestCase

  attr_reader :q 

  def setup
    @q = Queue.new('./event_attendees_small.csv')
  end

  def test_it_does_exist
    assert_kind_of Queue, q
  end

  def test_it_does_have_an_array
    assert_kind_of Array, q.attendees
  end

  def test_it_does_create_an_array_of_attendees
    q.attendees.each do |attendee|
      assert_kind_of Attendee, attendee
    end
  end
  
  def test_it_does_return_a_correct_count
    assert_equal q.attendees.count, q.count
  end

  def test_it_does_empty_the_queue
    q.clear
    assert_equal q.count, 0
  end

  def test_it_does_return_a_string_on_print
    printed = q.print
    assert_kind_of String, printed
  end

  def test_it_does_clean_the_data_fields
    q.attendees.each do |attendee|
      assert_kind_of DateTime, attendee.regdate
      assert_kind_of Zipcode, attendee.zipcode
      assert_kind_of PhoneNumber, attendee.homephone
    end
  end

  def test_it_does_find_all_by_attribute
    found_attendees = @q.find_by_attribute('zipcode', '20009')
    assert found_attendees.all? do |attendee|
      attendee.zipcode == '20009'
    end
  end

  def test_it_does_return_a_string_on_print_find
    assert_kind_of String, @q.print_find('last_name', 'Davis')
  end

end
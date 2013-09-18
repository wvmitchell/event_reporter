require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/queue'
require './lib/attendee'
require './lib/phone_number'

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
      assert_kind_of String, attendee.zipcode
      assert attendee.zipcode.length == 5, "Zipcode not 5 chars"
      assert_kind_of PhoneNumber, attendee.homephone
    end
  end
=begin

  def test_it_does_order_attendees_by_attribute
    q = Queue.new
    attributes = ['regdate', 'first_name', 'last_name', 'state', 'zipcode']
    attributes.each do |attribute|
      array = q.sort_by(attribute)
      assert_equal
    end
  end

=end
end
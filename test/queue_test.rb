require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/queue'
require './lib/attendee'

class QueueTest < MiniTest::Unit::TestCase

  def test_it_does_exist
    q = Queue.new
    assert_kind_of Queue, q
  end

  def test_it_does_have_an_array
    q = Queue.new
    assert_kind_of Array, q.attendees
  end

  def test_it_does_create_an_array_of_attendees
    q = Queue.new
    q.attendees.each do |attendee|
      assert_kind_of Attendee, attendee
    end
  end
  
  def test_it_does_return_a_correct_count
    q = Queue.new
    assert_equal q.attendees.count, q.count
  end

  def test_it_does_empty_the_queue
    q = Queue.new
    q.clear
    assert_equal q.count, 0
  end

  def test_it_does_return_a_string_on_print
    q = Queue.new
    printed = q.print
    assert_kind_of String, printed
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
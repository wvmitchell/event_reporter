require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/event_reporter'

class EventReporterTest < MiniTest::Unit::TestCase

  def test_does_exist
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

  def test_it_does_assign_root_command
    er = EventReporter.new
    er.command = ["load", "filename"]
    assert_equal 'load', er.root_command 
  end

  def test_changing_command_does_change_root_command
    er = EventReporter.new
    er.command = ['load', 'filename']
    assert_equal 'load', er.root_command
    er.command = ['queue', 'print']
    assert_equal 'queue', er.root_command
  end

  def test_load_does_assign_queue_object
    er = EventReporter.new
    er.load
    assert er.queue_object != nil, "Queue object has not been assigned"
  end

  def test_queue_count_does_return_correct_count
    er = EventReporter.new
    er.load 
    assert_equal er.queue_object.count, er.queue_count 
  end

  def test_queue_clear_does_clear_queue
    er = EventReporter.new
    er.load
    er.clear_queue
    assert_equal 0, er.queue_object.count
  end

  def test_commands_when_file_not_loaded_returns_graceful_error
   er = EventReporter.new
   er.command = ['queue', 'count']
   assert_equal 'Sorry, you need to load in a file first', er.queue_count
   er.command = ['find', 'zipcode', '80202']
   assert_equal 'Sorry, you need to load in a file first', er.find
   er.command = ['queue', 'print']
   assert_equal 'Sorry, you need to load in a file first', er.print 
   er.command = ['queue', 'save', 'to', 'filename']
   assert_equal 'Sorry, you need to load in a file first', er.save 
  end

  def test_find_does_return_string
    er = EventReporter.new
    er.load 
    er.command = ['find', 'zipcode', '80303']
    assert_kind_of String, er.execute_command
  end

  def test_print_by_attribute_returns_string
    er = EventReporter.new 
    er.load
    er.command = ['queue', 'print', 'by zipcode']
    assert_kind_of String, er.execute_command
  end
end
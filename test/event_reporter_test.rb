require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/event_reporter'

class EventReporterTest < MiniTest::Unit::TestCase

  def test_does_exist
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

  def rejects_invalid_commands
    er = EventReporter.new
    assert_false er.command_valid('potato')
  end

  def test_load_does_create_queue
    er = EventReporter.new
    er.load('event_attendees_small.csv')
    assert_kind_of Queue, er.queue_object
  end

end
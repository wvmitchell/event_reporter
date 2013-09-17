require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'
require './lib/help_message'

class EventReporterTest < MiniTest::Unit::TestCase

  def test_does_exist
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

  def rejects_invalid_commands
    er = EventReporter.new
    assert_false er.command_valid('potato')
  end

  def test_load_does_create_csv_object
    er = EventReporter.new
    er.load('event_attendees.csv')
    assert_kind_of CSV, er.csv
  end

end
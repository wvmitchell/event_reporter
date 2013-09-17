require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'
require './lib/help_message'

class EventReporterTest < MiniTest::Unit::TestCase

  def test_does_exist
    er = EventReporter.new
    assert_kind_of EventReporter, er
  end

  def test_load_does_create_csv_object
    er = EventReporter.new
    er.load('event_attendees.csv')
    assert_kind_of CSV, er.csv
  end

  def test_help_without_params_does_create_standard_message_object
    er = EventReporter.new
    m = er.help
    message = HelpMessage.new
    assert_equal m.message_to_output, message.message_to_output
  end

end
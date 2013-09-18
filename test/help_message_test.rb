require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/help_message'

class HelpMessageTest < MiniTest::Unit::TestCase

  def test_default_to_generic_help_message
    hm = HelpMessage.new
    message = HelpMessage.default_message
    assert_equal message, hm.message_to_output
  end

  def test_code_for_help_message_invalid
    hm = HelpMessage.new('potato')
    message = "Sorry, but I can't help you with that"
    assert_equal message, hm.message_to_output
  end

  def test_code_executes_correct_function
    ['load', 'queue', 'find'].each do |code|
      hm = HelpMessage.new([code])
      message = hm.send("#{code}_message")
      assert_equal message, hm.message_to_output  
    end
  end

  def test_uppercase_request_valid
    hm = HelpMessage.new(['LOAD'])
    message = hm.load_message
    assert_equal message, hm.message_to_output
  end

end
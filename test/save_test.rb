require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/save'
require './lib/queue'

class SaveTest < MiniTest::Unit::TestCase

  attr_reader :save_object

  def setup
    @save_object = Save.new
  end

  def test_it_does_exist
    assert_kind_of Save, save_object
  end

  def test_it_is_passed_queue
    assert_kind_of Queue, save_object.queue_obj 
  end

  def test_it_does_create_an_open_file
    assert_kind_of File, save_object.file_to_write
  end

  def test_it_does_close_file
    assert save_object.close == nil
  end

  def test_it_does_write_to_file
    q = Queue.new('./event_attendees_small.csv')
    write_save_object = Save.new(q, 'Write.txt')
    write_save_object.write
    write_save_object.close
    refute File.zero?(write_save_object.filename), "File is not being written too"
  end

  def test_it_does_save_on_execute
    q = Queue.new('./event_attendees_small.csv')
    write_save_object = Save.new(q, 'Execute.txt')
    write_save_object.execute
    refute File.zero?(write_save_object.filename), "File is not being written too"
  end

end
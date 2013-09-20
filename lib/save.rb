require './lib/queue'

class Save

  attr_reader :file_to_write, :filename, :queue_obj

  def initialize(queue_to_write = default_queue, filename = default_filename)
    @file_to_write = File.open filename, 'w'
    @filename = filename
    @queue_obj = queue_to_write
  end

  def default_filename
    'Output.txt'
  end

  def default_queue
    Queue.new('./event_attendees_small.csv')
  end

  def close
    file_to_write.close
  end

  def write
    file_to_write.write queue_obj.print
  end

  def execute
    write
    close
  end

end
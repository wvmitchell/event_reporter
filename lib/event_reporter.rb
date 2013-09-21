require 'csv'
require './lib/help_message'
require './lib/queue'
require './lib/save'

class EventReporter

  attr_accessor :queue_object, :command

  def run
    until root_command == 'quit'
      puts "What would you like to do?"
      @command = gets.chomp.split(' ',3)
      puts execute_command
    end
  end

  def execute_command
    case root_command
    when 'load' then load
    when 'help' then help
    when 'queue' then queue
    when 'find' then find
    when 'quit' then "Goodbye"
    else not_a_command
    end  
  end

  def root_command
    command ? command[0] : nil
  end

  def secondary_command
    command ? command[1] : nil
  end

  def command_options
    command ? command[2] : nil
  end

  def default_filename
    './event_attendees_small.csv'
  end

  def not_a_command
    "Sorry, there is no #{root_command} function!"
  end

  def find_filename
    secondary_command ? secondary_command : default_filename
  end

  def load
    @queue_object = Queue.new(find_filename)
    "Loaded #{find_filename}"
  end

  def help
    secondary_command ? specific_help : default_help
  end

  def default_help
    HelpMessage.new.message_to_output
  end

  def specific_help
    HelpMessage.new(secondary_command).message_to_output
  end    

  def queue
    case secondary_command
    when 'count' then queue_count
    when 'clear' then clear_queue
    when 'print' then print
    when 'save' then save
    else invalid_queue_command
    end
  end

  def invalid_queue_command
    "Invalid queue command. For help type 'help'"
  end

  def save
    queue_object ? execute_save : load_first_error
  end

  def execute_save
    options_array = command_options.split(' ')
    if options_array[0] == 'to' && options_array.length == 2
      Save.new(queue_object, options_array[1])
    else
      Save.new
      "Yeah...I just saved the whole file to output.txt, you can find it there"
    end
  end

  def queue_count
    queue_object ? queue_object.count : load_first_error
  end

  def clear_queue
    queue_object.clear
  end

  def print
    queue_object ? execute_print : load_first_error
  end

  def execute_print
    command_options.nil? ? queue_object.print : print_with_options
  end

  def print_with_options
    options_array = command_options.split(' ')
    attribute = options_array[1]
    valid_attribute?(attribute) ? queue_object.print_by_attribute(attribute) : "Invalid print options"
  end

  def valid_attribute?(attribute)
    [:first_name, :last_name, :email_address, :homephone, :street, :city, :state, :zipcode].include?(attribute.to_sym)
  end

  def find
    queue_object ? queue_object.print_find(secondary_command, command_options) : load_first_error
  end

  def load_first_error
    'Sorry, you need to load in a file first'
  end

end

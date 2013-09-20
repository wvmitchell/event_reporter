require 'csv'
require './lib/help_message'
require './lib/queue'
require './lib/save'

class EventReporter

  attr_reader :queue_object

  def initialize
    @queue_object = nil
  end

  def run
    command = ''
    until command == 'quit'
      puts "What would you like to do?"
      command = gets.chomp
      run_command command
    end
  end

  def run_command(command)
    command_parts = command.split(' ', 4)
    command_valid(command_parts[0]) ? run_valid_command(command_parts) : other_command(command_parts[0])
  end

  private

  def other_command(command)
    command == 'quit' ? (puts "Goodbye!") : not_a_command(command)
  end

  def not_a_command(command)
    puts "Sorry, there is no #{command} function!"
  end

  def command_valid(command)
    valid_commands = ['load', 'help', 'queue', 'find']
    valid_commands.include?(command)
  end

  def run_valid_command(parts_array)
    case parts_array[0]
    when 'load' then parts_array[1] ? load(parts_array[1]) : load
    when 'help' then help(parts_array[1..-1])
    when 'queue' then queue(parts_array[1..-1])
    when 'find' then find(parts_array[1..-1])
    end  
  end

  def load(filename='./event_attendees_small.csv')
    @queue_object = Queue.new(filename)
    @queue_object ? (puts "Successfully loaded #{filename}") : (puts "Sorry, couldn't load #{filename}")
  end

  def help(options)
    options.length == 0 ? (puts HelpMessage.new.message_to_output) : (puts HelpMessage.new(options).message_to_output)
  end

  def queue(options)
    case options[0]
    when 'count' then puts @queue_object.count
    when 'clear' then clear_queue
    when 'print' then (options.length == 1 ? (puts @queue_object.print) : (puts @queue_object.print_by_attribute(options[2])))
    when 'save' then save(options)
    else invalid_queue_command
    end
  end

  def invalid_queue_command
    puts "Invalid queue command. For help type 'help'"
  end

  def save(options)
    options.length == 3 ? Save.new(queue_object, options[2]).execute : (puts "Invalid save. For help type 'help'")
  end

  def clear_queue
    @queue_object.clear
    puts "The queue has been cleared"
  end

  def find(options)
    puts @queue_object.print_find(options[0], options[1])
  end

end

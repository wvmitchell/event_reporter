require 'csv'
require 'pry'
require './lib/help_message'
require './lib/queue'

class EventReporter

  attr_reader :queue_object

  def initialize
    @queue_object = nil
  end

  def run
    command = ''
    while command != 'quit'
      puts "What would you like to do?"
      command = gets.chomp
      execute_command command
    end
  end

  def execute_command(command)
    command_parts = command.split(' ')
    command_valid(command_parts[0]) ? run_valid_command(command_parts) : other_command(command_parts[0])
  end

  def other_command(command)
    command == 'quit' ? (puts "Goodbye!") : (puts "Sorry, I don't have a #{command} function!")
  end

  def command_valid(command)
    valid_commands = ['load', 'help', 'queue', 'find']
    valid_commands.include?(command)
  end

  def run_valid_command(parts_array)
    case parts_array[0]
    when 'load' then options?(parts_array[1..-1]) ? load(parts_array[1]) : load
    when 'help' then help(parts_array[1..-1])
    when 'queue' then queue(parts_array[1..-1])
    when 'find' then find(parts_array[1..-1])
    end  
  end

  def options?(array)
    !array.empty?
  end

  def load(filename='./event_attendees_small.csv')
    @queue_object = Queue.new(filename)
    @queue_object ? (puts "Successfully loaded #{filename}") : (puts "Sorry, couldn't load #{filename}")
  end

  def help(options)
    options.length == 0 ? (puts HelpMessage.new.message_to_output) : (puts HelpMessage.new(options).message_to_output)
  end

  def queue(options)
  end

  def find(options)
  end

end

#e = EventReporter.new
#e.run
require 'csv'
require './lib/help_message'

class EventReporter

  attr_reader :csv

  def initialize
    @csv = nil
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
    command_valid(command_parts[0]) ? run_valid_command(command_parts) : (puts "Sorry, I don't have a #{command_parts[0]} function!")
  end

  def command_valid(command)
    valid_commands = ['load', 'help', 'queue', 'find']
    valid_commands.include?(command)
  end

  def run_valid_command(parts_array)
    case parts_array[0]
    when 'load' then load(parts_array[1..-1])
    when 'help' then help(parts_array[1..-1])
    when 'queue' then queue(parts_array[1..-1])
    when 'find' then find(parts_array[1..-1])
    end  
  end

  def load(filename)
    @csv = CSV.open filename, headers: true, header_converters: :symbol
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
require "pry"

class HelpMessage

  attr_reader :message_to_output

  def initialize(code=nil)
    @message_to_output = code.nil? ? HelpMessage.default_message : interpret_code(code[0].downcase)
  end

  def self.default_message
    """
      There are several commands available to you

      load <filename> :
        load a new file with the given <filename>

      queue <count, clear, print> :
        <count> : give the number of items in the queue
        <clear> : empty the queue
        <print> : print the queue to the screen

      queue print by <attribute>
        print the queue to the screen organized by <attribute>

      queue save to <filename>
        save the queue to the given <filename>

      find <attribute> <criteria>
        load the queue with all records matching the <criteria> for the given <attribute>
    """
  end

  def interpret_code(code)
    case code
    when 'load' then load_message
    when 'queue' then queue_message
    when 'find' then find_message
    else 'Sorry, but I can\'t help you with that'
    end
  end

  def load_message
    """
      load <filename> :
        load a new file with the given <filename>
    """
  end

  def queue_message
    """
      queue <count, clear, print> :
        <count> : give the number of items in the queue
        <clear> : empty the queue
        <print> : print the queue to the screen

      queue print by <attribute>
        print the queue to the screen organized by <attribute>

      queue save to <filename>
        save the queue to the given <filename>
    """
  end

  def find_message
    """
      find <attribute> <criteria>
        load the queue with all records matching the <criteria> for the given <attribute>
    """
  end

end
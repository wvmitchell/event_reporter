require "csv"
require 'pry'
require './lib/attendee'
require './lib/phone_number'

class Queue

  attr_reader :attendees

  def initialize(filename)
    @attendees = create_attendees_array filename
  end

  def create_attendees_array(filename)
    csv = CSV.open filename, headers: true, header_converters: :symbol
    csv.collect do |row|
      arguments_hash = {}
      arguments_hash[:regdate]       = clean_date row[:regdate]
      arguments_hash[:first_name]    = row[:first_name]
      arguments_hash[:last_name]     = row[:last_name]
      arguments_hash[:email_address] = row[:email_address]
      arguments_hash[:homephone]     = clean_phone row[:homephone].to_s
      arguments_hash[:street]        = row[:street]
      arguments_hash[:city]          = row[:city]
      arguments_hash[:state]         = row[:state]
      arguments_hash[:zipcode]       = clean_zipcode row[:zipcode]
      Attendee.new arguments_hash
    end
  end

  def count
    @attendees.count
  end

  def clear
    @attendees.clear
  end

  def clean_date(date_string)
    DateTime.strptime(date_string, "%m/%d/%y %H:%M")
  end

  def clean_phone(phone_string)
    PhoneNumber.new(phone_string)
  end

  def clean_zipcode(zip_string)
    confirmed_zip_string = zip_string.nil? ? "" : zip_string
    confirmed_zip_string.to_s.rjust(5, '0')
  end

  def print(att=nil)
    return_string = "#{''.rjust(155, '-') + "\n" + 'LAST NAME'.ljust(15, " ") + 'FIRST NAME'.ljust(15, " ") + 'EMAIL ADDRESS'.ljust(35, ' ') +
                       'ZIPCODE'.ljust(10, " ") + 'CITY'.ljust(20, ' ') + 'STATE'.ljust(10, ' ') +
                       'ADDRESS'.ljust(35, " ") + 'PHONE'.ljust(15, ' ') + "\n" + ''.rjust(155, '-')}\n"
    
    attendees_to_print = att.nil? ? @attendees : att

    attendees_to_print.each do |attendee|
      return_string += "#{attendee.last_name.ljust(15, " ") + attendee.first_name.ljust(15, " ") +
                          attendee.email_address.ljust(35, ' ') + attendee.zipcode.to_s.ljust(10, ' ') +
                          attendee.city.ljust(20, " ") + attendee.state.ljust(10, ' ') +
                          attendee.street.ljust(35, ' ') + attendee.homephone.digits.ljust(15, ' ')}\n"
    end
    return_string
  end

  def sort_by(attribute)
    sorted_attendees = @attendees.sort_by {|attendee| attendee.send("#{attribute}")}
  end

  def print_by_attribute(attribute)
    print sort_by(attribute)
  end

end
class Attendee

  attr_reader :regdate, :first_name, :last_name, :email_address, :homephone, :street, :city, :state, :zipcode

  def initialize(data=nil)
    @regdate = data[:regdate]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email_address = data[:email_address]
    @homephone = data[:homephone]
    @street = data[:street]
    @city = data[:city]
    @state = data[:state]
    @zipcode = data[:zipcode]
  end

  def full_name
    @first_name+" "+@last_name
  end

end
class PhoneNumber
  include Comparable
  attr_reader :digits

  def initialize(number_string="0000000000")
    @digits = clean_phone number_string
  end

  def length
    digits.length
  end

  def <=>(other_phone)
    digits <=> other_phone.digits
  end

  def clean_phone(confirmed_phone_string)
    only_digits = confirmed_phone_string.tr('^0-9', '')
    only_digits = dispose_bad_values only_digits
    only_digits = truncate_country_code only_digits
  end

  def dispose_bad_values(string)
    (string.length > 11 || string.length < 10) ? "0000000000" : string
  end

  def truncate_country_code(string)
    string.length == 11 ? string[1..-1] : string 
  end

  def format_print
    "(#{digits[0..2]}) #{digits[3..5]}-#{digits[6..9]}"
  end
end
class Zipcode

  attr_reader :digits

  def initialize(num_string = "00000")
    @digits = clean(num_string)
  end

  private
  def clean(num_string)
    num_string.length > 5 ? "00000" : (pad num_string)
  end

  def pad(num_string)
    num_string.rjust(5, "0")
  end

end
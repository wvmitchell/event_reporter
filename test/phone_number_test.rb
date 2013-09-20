require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class PhoneNumberTest < MiniTest::Unit::TestCase

  attr_reader :phone 

  def setup
    @phone = PhoneNumber.new
  end

  def test_it_is_10_character_string
    assert phone.length == 10, "Number is supposed to be 10 chars and is instead #{phone.length}"
  end

  def test_it_cleans_bad_values
    phone_num = PhoneNumber.new("(302) * 453.2212")
    assert_equal "3024532212", phone_num.digits
  end

  def test_it_disposes_of_bad_values
    phone_num = PhoneNumber.new("130356543212343234234")
    assert_equal "0000000000", phone_num.digits
    phone_num = PhoneNumber.new("3452")
    assert_equal "0000000000", phone_num.digits
  end

  def test_it_truncates_11_nums_to_10
    phone_num = PhoneNumber.new("13034945255")
    assert_equal "3034945255", phone_num.digits
  end

  def test_it_correctly_compares_numbers
    phone_num = PhoneNumber.new("2034945255")
    phone_num2 = PhoneNumber.new("3034945255")
    assert phone_num < phone_num2, "Comparison is not correct"
  end
end
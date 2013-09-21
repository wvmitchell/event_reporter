require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class ZipcodeTest < MiniTest::Unit::TestCase

  def test_it_does_create_default
    zip = Zipcode.new
    assert_equal "00000", zip.digits
  end

  def test_it_does_reject_numbers_too_long
    zip = Zipcode.new("9823424234")
    assert_equal "00000", zip.digits
  end

  def test_it_does_pad_zips_which_are_too_short
    zip = Zipcode.new("124")
    assert_equal "00124", zip.digits
  end

  def test_it_should_compare_two_zipcodes
    zip = Zipcode.new("00001")
    zip2 = Zipcode.new("00002")
    assert zip < zip2
  end

  def test_it_does_create_correct_size_zip_from_blank_space
    zip = Zipcode.new(" 123")
    assert_equal "00123", zip.digits 
  end
  
end
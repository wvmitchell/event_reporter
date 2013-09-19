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

end
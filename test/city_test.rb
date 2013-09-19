require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/city.rb'


class CityTest < MiniTest::Unit::TestCase

  def test_it_does_not_return_nil
    ci = City.new
    assert !ci.city_name.nil?
  end

  def test_it_should_compare_city_name
    city = City.new("Atlanta")
    city2= City.new("Chicago")
    assert city < city2
  end
end
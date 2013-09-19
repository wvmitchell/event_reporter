class City
  include Comparable

  attr_reader :city_name

  def initialize(city = "No Name")
    @city_name = city
  end

  def <=>(other)
    if self.city_name.upcase < other.city_name.upcase
      -1
    elsif self.city_name.upcase > other.city_name.upcase
      1
    else
      0
    end
  end
end
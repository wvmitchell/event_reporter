class City
  include Comparable

  attr_reader :city_name

  def initialize(city = "No Name")
    @city_name = city.capitalize
  end

  def <=>(other)
    if self.city_name < other.city_name
      -1
    elsif self.city_name > other.city_name
      1
    else
      0
    end
  end
end
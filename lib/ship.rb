class Ship

  attr_reader :coordinates, :hits, :length

  def initialize(coordinates)
    @coordinates = coordinates
    @length = coordinates.length
    @hits = Array.new(coordinates.length){false}
  end

  def check_if_ship_is_sank?
    hits.all? do |hit|
       hit == true
    end
  end

  def hit_ship(coordinate)
    hit_location = @coordinates.index(coordinate)
    @hits[hit_location] = true
  end

end

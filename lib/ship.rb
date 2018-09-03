class Ship

  attr_reader :coordinates, :hits, :length

  def initialize(coordinates)
    @coordinates = coordinates
    @length = coordinates.length
    @hits = Array.new(coordinates.length){false}
  end


end

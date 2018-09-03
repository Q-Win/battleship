require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require 'pry'

class ShipTest < Minitest::Test

  def test_it_exists
    ship = Ship.new(["A1","A2"])

    assert_instance_of Ship, ship
  end

  def test_it_has_length
    ship = Ship.new(["A1","A2"])
    ship_2 = Ship.new(["A2","B2","C2","D2"])

    assert_equal 2, ship.length
    assert_equal 4, ship_2.length

  end

  def test_ships_come_with_no_hits
    ship = Ship.new(["A1","A2"])
    ship_2 = Ship.new(["A2","B2","C2","D2"])

    assert_equal [false,false], ship.hits
    assert_equal [false,false,false,false], ship_2.hits
  end

  def test_we_can_hit_a_ship
    ship_2 = Ship.new(["A2","B2","C2","D2"])

    ship_2.hit_ship("C2")

    assert ship_2.hits[2]
    refute ship_2.hits[0]
    refute ship_2.hits[1]
    refute ship_2.hits[3]
  end

  def test_it_can_tell_if_a_ship_has_sank
    ship = Ship.new(["A2","A3"])

    refute ship.check_if_ship_is_sank?

    ship.hit_ship("A2")

    refute ship.check_if_ship_is_sank?

    ship.hit_ship("A3")

    assert ship.check_if_ship_is_sank?
  end



end

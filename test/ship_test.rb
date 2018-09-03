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

end

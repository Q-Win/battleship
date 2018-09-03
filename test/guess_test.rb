require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/guess'

class BoardTest < Minitest::Test

  def test_it_exists
    guess = Guess.new(4)

    assert_instance_of Guess, guess
  end

  def test_it_has_a_board
    guess = Guess.new(3)

    expected_3 = [[' ', ' ',' '],[' ', ' ',' '],[' ', ' ',' ']]

    assert_equal expected_3, guess.board
  end 

end

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

  def test_it_can_record_hit_or_miss
    guess = Guess.new(4)
    board = Board.new(4,guess)
    ship = Ship.new(["A1","A2"])

    board.place_ship(ship)

    assert_equal " ", guess.board[0][1]
    assert_equal " ", guess.board[2][3]

    board.record_guess("A2")
    board.record_guess("C4")

    assert_equal "H", guess.board[0][1]
    assert_equal "M", guess.board[2][3]
  end

  def test_it_can_print_board
    guess = Guess.new(4)
    board = Board.new(4,guess)
    ship = Ship.new(["A1","A2"])

    board.place_ship(ship)

    assert guess.print_board
  end

  def test_it_can_build_a_board
    guess = Guess.new(4)
    board = Board.new(4,guess)
    ship = Ship.new(["A1","A2"])

    board.place_ship(ship)

    assert guess.build_board(4)
  end

end

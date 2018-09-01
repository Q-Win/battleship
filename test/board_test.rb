require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'

class BoardTest < Minitest::Test

    def test_it_exists
      board = Board.new(3)

      assert_instance_of Board, board
    end

    def test_it_has_a_blank_board_by_default
      board_1 = Board.new(1)
      board_3 = Board.new(3)

      expected_1 = [[' ']]
      expected_3 = [[' ', ' ',' '],[' ', ' ',' '],[' ', ' ',' ']]

      assert_equal expected_1, board_1.board
      assert_equal expected_3, board_3.board
    end

    def test_there_are_no_ships_at_first
      board_3 = Board.new(3)

      assert_equal [], board_3.ships
    end
end

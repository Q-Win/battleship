require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/guess'

class BoardTest < Minitest::Test

    def test_it_exists
      guess = Guess.new(3)
      board = Board.new(3, guess)

      assert_instance_of Board, board
    end

    def test_it_has_a_blank_board_by_default
      guess_1 = Guess.new(1)
      guess_3 = Guess.new(3)
      board_1 = Board.new(1,guess_1)
      board_3 = Board.new(3,guess_3)

      expected_1 = [[' ']]
      expected_3 = [[' ', ' ',' '],[' ', ' ',' '],[' ', ' ',' ']]

      assert_equal expected_1, board_1.board
      assert_equal expected_3, board_3.board
    end

    def test_there_are_no_ships_at_first
      guess_3 = Guess.new(3)
      board_3 = Board.new(3,guess_3)

      assert_equal [], board_3.ships
    end

    def test_it_can_print_board
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship = Ship.new(["A1","A2"])

      board.place_ship(ship)

      assert board.print_board
    end

    def test_we_can_place_ships_on_board
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship = Ship.new(["A1","A2"])

      board.place_ship(ship)

      assert_equal "S", board.board[0][0]
      assert_equal "S", board.board[0][1]
      assert_equal " ", board.board[2][2]
      assert_equal " ", board.board[3][1]
    end

    def test_record_guess_updates_previous_guesses
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship = Ship.new(["A1","A2"])

      board.place_ship(ship)

      assert_equal [],


      board.guess.previous_guesses

      board.record_guess("A2")

      assert_equal ["A2"], board.guess.previous_guesses
    end

    def test_record_guess_can_update_guess_board
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship = Ship.new(["A1","A2"])

      board.place_ship(ship)

      assert_equal " ", board.guess.board[0][1]
      assert_equal " ", board.guess.board[2][3]

      board.record_guess("A2")
      board.record_guess("C4")

      assert_equal "H", board.guess.board[0][1]
      assert_equal "M", board.guess.board[2][3]
    end

    def test_record_guess_can_hit_ships
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship = Ship.new(["A1","A2"])

      board.place_ship(ship)

      board.record_guess("A2")

      assert board.ships[0].hits[1]
      refute board.ships[0].hits[0]
    end

    def test_reocrd_guess_can_check_if_a_ship_is_there
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship = Ship.new(["A1","A2"])

      board.place_ship(ship)
      coordinate = "A2"

      assert_equal "S", board.board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1]
    end

    def test_we_can_check_if_all_ships_are_sank
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship = Ship.new(["A1","A2"])
      ship_2 = Ship.new(["B2","C2","D2"])

      board.place_ship(ship)
      board.place_ship(ship_2)

      board.record_guess("A1")
      board.record_guess("A2")
      board.record_guess("B2")
      board.record_guess("C2")

      refute board.check_if_all_ships_sank?

      board.record_guess("D2")

      assert board.check_if_all_ships_sank?
    end


end

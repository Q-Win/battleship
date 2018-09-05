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

    def test_we_can_check_if_guess_is_2_chars
      guess = Guess.new(4)
      board = Board.new(4,guess)

      assert board.validate_guess_is_2_chars("A1")
      refute board.validate_guess_is_2_chars("A21")
      refute board.validate_guess_is_2_chars("D")
    end

    def test_it_can_check_its_a_letter_and_number
      guess = Guess.new(4)
      board = Board.new(4,guess)

      assert board.validate_is_a_letter_and_number("A1")
      refute board.validate_is_a_letter_and_number("E1")
      refute board.validate_is_a_letter_and_number("44")
      refute board.validate_is_a_letter_and_number("1A")
      refute board.validate_is_a_letter_and_number("21")
      refute board.validate_is_a_letter_and_number("AA")

    end

    def test_we_can_check_its_not_a_repeated_guess
      guess = Guess.new(4)
      board = Board.new(4,guess)

      board.record_guess("A1")

      assert board.validate_guess_isnt_a_repeat("A2")
      refute board.validate_guess_isnt_a_repeat("A1")
    end

    def test_we_can_check_if_a_guess_is_valid
      guess = Guess.new(4)
      board = Board.new(4,guess)

      board.record_guess("A1")

      assert board.validate_guess("A2")
      refute board.validate_guess("A21")
      refute board.validate_guess("D")
      refute board.validate_guess("E1")
      refute board.validate_guess("44")
      refute board.validate_guess("1A")
      refute board.validate_guess("21")
      refute board.validate_guess("AA")
    end

    def test_we_can_check_ship_has_correct_length
      guess = Guess.new(4)
      board = Board.new(4,guess)

      assert board.validate_ship_has_correct_length(["A1","A2"],2)
    end

    def test_we_can_check_the_ships_direction
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship_1 = ["A1","A2"]
      ship_2 = ["B3","C3"]

      assert_equal "horizontal",board.get_ships_direction(ship_1)
      assert_equal "vertical", board.get_ships_direction(ship_2)
    end

    def test_we_can_check_ships_keep_direction
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship_1 = ["A1","A2","A3"]
      ship_2 = ["B3","C3","D3"]
      ship_3 = ["A1","B2","A3"]
      ship_4 = ["B3","C2","D3"]

      assert board.validate_ship_keeps_direction(ship_1)
      assert board.validate_ship_keeps_direction(ship_2)
      refute board.validate_ship_keeps_direction(ship_3)
      refute board.validate_ship_keeps_direction(ship_4)
    end

    def test_we_can_check_ships_are_continous
      guess = Guess.new(4)
      board = Board.new(4,guess)
      ship_1 = ["A1","A2","A3"]
      ship_2 = ["B3","C3","D3"]
      ship_3 = ["A1","A2","A4"]
      ship_4 = ["A3","C2","D3"]

      assert board.validate_ship_is_continous(ship_1,3)
      assert board.validate_ship_is_continous(ship_2,3)
      refute board.validate_ship_is_continous(ship_3,3)
      refute board.validate_ship_is_continous(ship_4,3)
    end

end

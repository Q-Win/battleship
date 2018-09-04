require 'pry'
require './lib/ship'
require './lib/guess'

class Board

  attr_reader :board, :ships, :guess

  def initialize (board_size,guess)
    @board = build_board(board_size)
    @ships = []
    @guess = guess
  end

  def build_board(i)
    board_array = Array.new(i){Array.new(i)}
    board_array.map do |array|
      array.map do |spot|
        spot = ' '
      end
    end
  end

  def print_board
    i = 65
    p "================="
    p ".| 1 | 2 | 3 | 4"
    board.each do |row|
      p"-----------------"
      p "#{i.chr}| #{row.join(" | ")}"
      i += 1
    end
    p "================="

  end

  def place_ship(ship)
    @ships << ship
    ship.coordinates.each do |coordinate|
      @board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1] = "S"
    end
  end

  def record_guess(coordinate)
    @guess.previous_guesses << coordinate
    if @board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1] == "S"
      p "hit"
      @board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1] = "H"

      ship_index = @ships.find_index{|ship| ship.coordinates.any?{ |coord| coord == coordinate} == true}

      @ships[ship_index].hit_ship(coordinate)

      @guess.record_hit_or_miss(coordinate,"H")
    else
      p "miss"
      @board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1] = "M"
      @guess.record_hit_or_miss(coordinate,"M")
    end

  end

  def check_if_all_ships_sank?
    @ships.all? {|ship| ship.check_if_ship_is_sank? == true }
  end

  def validate_guess(coordinate)
    validate_guess_is_2_chars(coordinate) &&
    validate_is_a_letter_and_number(coordinate) &&
    validate_guess_isnt_a_repeat(coordinate)
  end

  def validate_guess_is_2_chars(coordinate)
    if coordinate.length != 2
      p "Invalid guess. Coordinates need to be exactly 2 characters long"
    end

    coordinate.length == 2
  end

  def validate_is_a_letter_and_number(coordinate)
    if coordinate[0].ord.between?(65,68) == false
      p "Invalid coordinate. Coordinates must start with A,B,C,or D."
    end

    if coordinate[1].to_i.between?(1,4) == false
      p "Invalid coordinate. 2nd character must be a 1,2,3,or 4."
    end

    coordinate[0].ord.between?(65,68) &&
    coordinate[1].to_i.between?(1,4)
  end

  def validate_guess_isnt_a_repeat(coordinate)
    @guess.previous_guesses.none? {|guess| guess == coordinate}
  end

  def validate_ship_placement(coordinates, length)

  end

  def validate_ship_has_correct_length(coordinates,length)
    coordinates.length == length

  end

  def get_ships_direction(coordinates)
    
  end



end

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
    if validate_guess_is_2_chars(coordinate) == false
      puts "Coordinates need to be 2 characters long"
    elsif validate_is_a_letter_and_number(coordinate) == false
      puts "Coordinates must be a letter followed by a number"
    elsif validate_guess_isnt_a_repeat(coordinate) == false
      puts "You have already guessed that spot"
    end

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
    if validate_ship_has_correct_length(coordinates,length) == false
      puts "Ship is incorrect length"
    elsif validate_ship_keeps_direction(coordinates) == false
      puts "Ship is not straight"
    elsif validate_ship_is_continous(coordinates,length) == false
      puts "Ship is not continous"
    elsif validate_ship_doesnt_overlap(coordinates,length) == false
      puts "Ship can not wrap around board"
    elsif validate_ships_arent_placed_on_existing_ship(coordinates) == false
      "Ship already occupying that spot"
    end

    (validate_ship_has_correct_length(coordinates,length) &&
    validate_ship_keeps_direction(coordinates) &&
    validate_ship_is_continous(coordinates,length) &&
    validate_ship_doesnt_overlap(coordinates,length) &&
    validate_ships_arent_placed_on_existing_ship(coordinates))
  end

  def validate_ship_has_correct_length(coordinates,length)
    coordinates.length == length
  end

  def get_ships_direction(coordinates)
    if coordinates[0][0] == coordinates[-1][0]
      "horizontal"
    elsif
      coordinates[0][1] == coordinates[-1][1]
      "vertical"
    end
  end

  def validate_ship_keeps_direction(coordinates)
    if get_ships_direction(coordinates) == "horizontal"
      check = coordinates[0][0]
      coordinates.all? {|coordinate| coordinate[0] == check}
    elsif get_ships_direction(coordinates) == "vertical"
      check = coordinates[0][1]
      coordinates.all? {|coordinate| coordinate[1] == check}
    end
  end

  def validate_ship_is_continous(coordinates,length)
    if get_ships_direction(coordinates) == "horizontal"

      run_times = (length - 2)
      checks = []

      for i in 0..run_times do

        checks << (coordinates[i][1].to_i == coordinates[i+1][1].to_i - 1)
      end
      checks.all? {|check| check == true}


    elsif get_ships_direction(coordinates) == "vertical"
      run_times = length - 2
      checks = []
      for i in 0..run_times do
        checks << (coordinates[i][0].ord == coordinates[i+1][0].ord - 1)
      end
      checks.all? {|check| check == true}
    end
  end

  def validate_ship_doesnt_overlap(coordinates,length)
    if get_ships_direction(coordinates) == "horizontal"
      (coordinates[0][1].to_i + length) <= 5
    elsif get_ships_direction(coordinates) == "vertical"
      (coordinates[0][0].ord + length) <= 69
    end
  end

  def validate_ships_arent_placed_on_existing_ship(coordinates)
    coordinates.none? {|coordinate| @board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1] == "S"}
  end

end

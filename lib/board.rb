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



end

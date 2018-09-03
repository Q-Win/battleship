require 'pry'
require './lib/ship'

class Board

  attr_reader :board, :ships

  def initialize (board_size)
    @board = build_board(board_size)
    @ships = []
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
    "Work In Progress"
  end

  def place_ship(ship)
    @ships << ship
    ship.coordinates.each do |coordinate|
      @board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1] = "S"
    end
  end

end


# board = Board.new(4)
# ship = Ship.new(["A1","A2"])
# ship_2 = Ship.new(["A2","B2","C2","D2"])

require 'pry'

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
  end

end

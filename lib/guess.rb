class Guess

  attr_reader :board, :previous_guesses

  def initialize(i)
    @previous_guesses = []
    @board = build_board(i)

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

  def record_hit_or_miss(coordinate, letter)
    @board[((coordinate[0].ord) - 65)][(coordinate[1].to_i)-1] = letter
  end

end

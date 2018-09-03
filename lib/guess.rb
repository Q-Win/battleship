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

end

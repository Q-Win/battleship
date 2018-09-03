require './lib/board'
require './lib/ship'
require './lib/guess'
require 'pry'

player_guesses = Guess.new(4)
pc_guesses = Guess.new(4)

player_board = Board.new(4,pc_guesses)
pc_board = Board.new(4,player_guesses)

pc_ship_2 = Ship.new(["A1","A2"])
pc_ship_3 = Ship.new(["A3","B3","C3"])
player_ship_2 = Ship.new(["A1","A2"])
player_ship_3 = Ship.new(["A3","B3","C3"])

player_board.place_ship(player_ship_2)
player_board.place_ship(player_ship_3)
pc_board.place_ship(pc_ship_2)
pc_board.place_ship(pc_ship_2)


binding.pry

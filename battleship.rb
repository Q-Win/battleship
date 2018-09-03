require './lib/board'
require './lib/ship'
require './lib/guess'

player_board = board.(4)
pc_board = board.(4)

pc_ship_2 = Ship.new(["A1","A2"])
pc_ship_3 = Ship.new(["A3","B3","C3"])
player_ship_2 = Ship.new(["A1","A2"])
player_ship_3 = Ship.new(["A2","B2","C2"])

player_guesses = Guess.new(4)

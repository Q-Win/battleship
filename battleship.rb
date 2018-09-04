require './lib/board'
require './lib/ship'
require './lib/guess'
require 'pry'

pc_guesses = ["A1","A2","A3","A4","B1","B2","B3","B4",
              "C1","C2","C3","C4","D1","D2","D3","D4"].shuffle

player_guess = Guess.new(4)
pc_guess = Guess.new(4)

player_board = Board.new(4,pc_guess)
pc_board = Board.new(4,player_guess)

p "Please give coordiantes for a 2 unit ship"
player_ship_2_coord = gets.chomp.split

p "Please give coordiantes for a 3 unit ship"
player_ship_3_coord = gets.chomp.split

pc_ship_2 = Ship.new(["A1","A2"])
pc_ship_3 = Ship.new(["A3","B3","C3"])
player_ship_2 = Ship.new(player_ship_2_coord)
player_ship_3 = Ship.new(player_ship_3_coord)

player_board.place_ship(player_ship_2)
player_board.place_ship(player_ship_3)
pc_board.place_ship(pc_ship_2)
pc_board.place_ship(pc_ship_3)

while (pc_board.check_if_all_ships_sank? == false && player_board.check_if_all_ships_sank? == false)

p "YOUR CURRENT GUESS ATTEMPTS"
player_guess.print_board
p "Choose a coordinate to attack"
player_guess_attempt = gets.chomp
pc_board.record_guess(player_guess_attempt)
player_board.record_guess(pc_guesses.pop)
p "PC GUESS RECORD"
player_board.print_board

end




# binding.pry

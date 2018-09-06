require './lib/board'
require './lib/ship'
require './lib/guess'
require 'pry'
puts "Welcome to BATTLESHIP"
pc_guesses = ["A1","A2","A3","A4","B1","B2","B3","B4",
              "C1","C2","C3","C4","D1","D2","D3","D4"].shuffle

player_guess = Guess.new(4)
pc_guess = Guess.new(4)

player_board = Board.new(4,pc_guess)
pc_board = Board.new(4,player_guess)
player_input = ""

while (player_input != "p")
p "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
player_input = gets.chomp

  if player_input == "q"
    exit
  elsif player_input == "i"
    p "Welcome to Battleship! We will begin by entering our ships coordiantes"
    p "Enter the coordinates letter first then number. Enter all letters as uppercase"
    p "Ships cannot wrap around the board. Ships must be continous. Ships cannot go past"
    p "the board's range. The board is a 4x4 grid. You will enter coordinates to guess"
    p "where you want to attack."

  end
end

p "I have laid out my ships on the grid."
p "You now need to layout your two ships."
p "The first is two units long and the"
p "second is three units long."
p "The grid has A1 at the top left and D4 at the bottom right."
p "Enter the squares for the two-unit ship:"
p "press ENTER when you are ready to continue"

gets

p "Please give coordiantes for a 2 unit ship"
player_ship_2_coord = gets.chomp.split
until (player_board.validate_ship_placement(player_ship_2_coord,2) == true)
  p "INVALID SHIP PLACEMENT!!!"
  p "Please reenter ship coordinates"
  player_ship_2_coord = gets.chomp.split
end

player_ship_2 = Ship.new(player_ship_2_coord)
player_board.place_ship(player_ship_2)

p "Please give coordiantes for a 3 unit ship"
player_ship_3_coord = gets.chomp.split
until (player_board.validate_ship_placement(player_ship_3_coord,3) == true)
  p "INVALID SHIP PLACEMENT!!!"
  p "Please reenter ship coordinates"
  player_ship_3_coord = gets.chomp.split
end

player_ship_3 = Ship.new(player_ship_3_coord)
player_board.place_ship(player_ship_3)

pc_ship_2 = Ship.new(["A1","A2"])
pc_ship_3 = Ship.new(["A3","B3","C3"])

pc_board.place_ship(pc_ship_2)
pc_board.place_ship(pc_ship_3)

while (pc_board.check_if_all_ships_sank? == false && player_board.check_if_all_ships_sank? == false)


p "Choose a coordinate to attack"
player_guess_attempt = gets.chomp
until (pc_board.validate_guess(player_guess_attempt) == true)
  p "INVALID SHIP PLACEMENT!!!"
  p "Please reenter guess"
  player_guess_attempt = gets.chomp
end
p "Your attempt is a"
pc_board.record_guess(player_guess_attempt)
p "YOUR CURRENT GUESS ATTEMPTS"
player_guess.print_board
p"press enter to continue"
gets
p "The PC's attempt is a"
player_board.record_guess(pc_guesses.pop)
p "PC GUESS RECORD"
player_board.print_board

end

if pc_board.check_if_all_ships_sank? == true
  puts "You are victorious!!!"
else
  puts "Sorry you have lost"
end

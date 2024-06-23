require_relative "lib/game"
require_relative "lib/player"

def continue_previous_game?
  puts "Do you want to continue a previously saved game? (Y/N)"
  loop do
    player_decision = gets.chomp.downcase

    break player_decision if player_decision == "y" || player_decision == "n"

    puts "Invalid choice. Input must be Y or N."
  end
end

player_decision = continue_previous_game?

game = Game.new
game.play_game(game)

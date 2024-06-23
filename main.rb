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

def load_previous_game
  unless File.exist? "last_saved_game_file"
    return puts "No previously saved game was found. Try your luck with a new game."
  end

  de_serialized_game = YAML.unsafe_load File.read("last_saved_game_file")

  ### make some reading if I correctly de-serialized safe vs unsafe load. Are there other options??
  de_serialized_game.play_game(de_serialized_game)
end

player_decision = continue_previous_game?

if player_decision == "y"
  load_previous_game
else
  game = Game.new
  game.play_game(game)
end

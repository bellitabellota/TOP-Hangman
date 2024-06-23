require_relative "lib/game"
require_relative "lib/player"

require "yaml" ##??can also be put in main.rb??


game = Game.new
game.play_game(game)

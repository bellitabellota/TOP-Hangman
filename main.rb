puts "Hangman started"

class Game
  attr_reader :words, :secret_word

  def initialize
    @words = File.readlines("google-10000-english-no-swears.txt")
    @secret_word = select_secret_word(words)
  end

  def select_secret_word(words)
    medium_length_words = words.map do |word|
      word.chomp if word.length > 5 && word.length < 12
    end

    medium_length_words.compact.sample
  end
end

game = Game.new

puts game.secret_word

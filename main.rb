class Game
  attr_reader :words, :secret_word
  attr_accessor :lines

  def initialize
    @words = File.readlines("google-10000-english-no-swears.txt")
    @secret_word = select_secret_word(words)
    @lines = Array.new(11, " ")
  end

  def select_secret_word(words)
    medium_length_words = words.map do |word|
      word.chomp if word.length > 5 && word.length < 12
    end

    medium_length_words.compact.sample
  end

  def play_game
    wrong_guesses = 1
    self.lines = make_stroke(wrong_guesses)
    display_stick_figure(lines)
  end

  def make_stroke(wrong_guesses)
    case wrong_guesses
    when 1
      lines[0] = "___"
    when 2
      lines[1] = "|"
    when 3
      lines[2] = "___________"
    when 4
      lines[3] = "/"
    when 5
      lines[4] = "|"
    when 6
      lines[5] = "(_)"
    when 7
      lines[6] = "|"
    when 8
      lines[7] = "/"
    when 9
      lines[8] = "\\"
    when 10
      lines[9] = "/"
    when 11
      lines[10] = "\\"
    end
    lines
  end

  def display_stick_figure(lines)
    puts "    #{lines[2]}"
    puts "   #{lines[1]} #{lines[3]}         #{lines[4]}"
    puts "   #{lines[1]}#{lines[3]}         #{lines[5]}"
    puts "   #{lines[1]}          #{lines[7]}#{lines[6]}#{lines[8]}"
    puts "   #{lines[1]}           #{lines[6]}"
    puts "   #{lines[1]}          #{lines[9]} #{lines[10]}"
    puts "   #{lines[1]}"
    puts "   #{lines[1]}"
    puts "#{lines[0]}#{lines[1]}#{lines[0]}"
    puts
  end
end

game = Game.new
game.play_game

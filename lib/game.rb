require "yaml"

class Game
  attr_reader :words, :secret_word, :player
  attr_accessor :lines, :matching_guesses, :number_wrong_guesses, :wrong_guesses, :game_finished

  def play_game(game)
    player_decision = player.continue_previous_game?


    display_matching_guesses
    until number_wrong_guesses == 11
      wants_to_save = player.save_game?
      if wants_to_save == "y"
        save_game(game)
      end

      play_one_round
      return if game_finished == true
    end

    puts "You lost! The secret word was: #{secret_word}."
  end

  private

  def initialize
    @words = File.readlines("google-10000-english-no-swears.txt")
    @secret_word = select_secret_word(words)
    @lines = Array.new(11, " ")
    @player = Player.new
    @matching_guesses = Array.new(secret_word.length, "_")
    @number_wrong_guesses = 0
    @wrong_guesses = []
    @game_finished = false
  end

  def save_game(game)
    serialized_object = YAML.dump(game)
    last_saved_game_file = File.new "last_saved_game_file", "w"
    last_saved_game_file.puts serialized_object
    last_saved_game_file.close
  end

  def select_secret_word(words)
    medium_length_words = words.map do |word|
      word.chomp if word.length > 5 && word.length < 12
    end

    medium_length_words.compact.sample
  end

  def play_one_round
    player_guess = player.get_player_guess(secret_word)

    evaluate_guess(player_guess)

    check_for_win(player_guess)
    return if game_finished == true

    display_matching_guesses

    self.lines = make_stroke(number_wrong_guesses)
    display_stick_figure(lines) if number_wrong_guesses != 0
    display_wrong_guesses
  end

  def check_for_win(player_guess)
    return unless player_guess == secret_word || matching_guesses.join == secret_word

    self.game_finished = true
    puts "You won! The secret word was: #{secret_word}."
  end

  def evaluate_guess(player_guess)
    if (player_guess != secret_word && player_guess.length > 1) ||
       (player_guess.length == 1 && !secret_word.include?(player_guess))
      self.number_wrong_guesses += 1
      wrong_guesses.push(player_guess)
    elsif player_guess.length == 1 && secret_word.include?(player_guess)
      update_matching_guesses(player_guess)
    end
  end

  def update_matching_guesses(player_guess)
    secret_word.chars.each_with_index do |secret_letter, secret_letter_index|
      matching_guesses[secret_letter_index] = player_guess.to_s if secret_letter == player_guess
    end
  end

  def display_wrong_guesses
    print "Wrong guesses: "
    wrong_guesses.each { |guess| print " #{guess}" }
    puts "0" if wrong_guesses == []
    puts
  end

  def display_matching_guesses
    puts
    print "Secret word:"
    matching_guesses.each { |letter| print " #{letter}" }
    puts
  end

  def make_stroke(number_wrong_guesses)
    case number_wrong_guesses
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

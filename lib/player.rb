class Player
  def get_player_guess(secret_word)
    puts "Please enter your guess:"
    loop do
      player_guess = gets.chomp.downcase

      break player_guess if ("a".."z").any?(player_guess) || player_guess.length == secret_word.length

      puts "Invalid choice. Input must be single letter or whole word."
    end
  end

  def save_game?
    puts "Do you want to save the game before making your guess? (Y/N)"
    loop do
      player_answer = gets.chomp.downcase

      break player_answer if player_answer == "y" || player_answer == "n"

      puts "Invalid choice. Input must be Y or N."
    end
  end

  def continue_previous_game?
    puts "Do you want to continue a previously saved game? (Y/N)"
    loop do
      player_decision = gets.chomp.downcase

      break player_decision if player_decision == "y" || player_decision == "n"

      puts "Invalid choice. Input must be Y or N."
    end
  end
end

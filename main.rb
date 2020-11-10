require_relative 'lib/secret'

puts "New game(n) or saved game(s)? "
new_save_choice = gets.chomp.downcase
if new_save_choice == 's'
  puts "What's the filename?"
  name = gets.chomp.downcase
  filename = "saved/#{name}"

  game = Secret.load_game(filename)
else
  game = Secret.new
end

while true
  game.display_status
  puts "\nWhat's your next choice, Padawan? (enter 'save' to save the current game)"
  choice = gets.chomp.downcase
  
  if choice == 'save'
    game.save_game
    abort("Just saved the game for you! Come again!")
  end
  if game.correct_choices.include?(choice) || game.wrong_guesses.include?(choice)
    puts "you already made that guess"
    redo
  else
    game.play_choice(choice)
  end
  game.display_status

  if game.wrong_counter == 6
    puts "You've lost! The word was #{game.secret_word}"
    break
  elsif game.is_complete?
    puts "You've Won!!"
    puts "The word was #{game.secret_word}! You're now a Jedi!"
    break
  end
end
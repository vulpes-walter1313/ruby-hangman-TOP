require 'json'

class Secret
  attr_reader :secret_word
  attr_accessor :wrong_counter, :wrong_guesses, :correct_choices
  def initialize(wrong_cnt=0, wrong_gsses=[], correct_chcs=[], secret=nil)
    if secret.nil?
      @secret_word = self.select_secret_word
    else
      @secret_word = secret
    end
    @wrong_counter = wrong_cnt
    @wrong_guesses = wrong_gsses
    @correct_choices = correct_chcs
  end

  def select_secret_word
    File.open("files/5desk.txt", 'r') do |file|
      words = []
      count = 0
      until file.eof?
        count += 1
        word = file.readline.chomp
        if word.length >= 5 && word.length <= 12
          words.push(word.downcase)
        end
      end
      words.uniq.sample
    end
  end

  def display_status
    # The purpose of this Method is to display: wrong guess counter, wrong guess choices,
    # and correct choices
    puts "\nWrong Counter: #{wrong_counter}"
    puts "Wrong Choices: #{wrong_guesses.join(", ")}"
    disp = secret_word.chars.map {|ltr| correct_choices.include?(ltr) ? ltr : "-"}
    disp.each { |l| print l}
    puts ""    

  end

  def play_choice(char)
    if secret_word.chars.include?(char)
      self.correct_choices.push(char)
    else
      self.wrong_guesses.push(char)
      self.wrong_counter += 1
    end
  end

  def is_complete?
    secret_word.chars.all? { |l| self.correct_choices.include?(l)}
  end

  def save_game
    data = JSON.dump({
      secret_word: self.secret_word,
      wrong_counter: self.wrong_counter,
      wrong_guesses: self.wrong_guesses,
      correct_choices: self.correct_choices
    })

    t = Time.now
    filename = "game-#{t.to_a[4]}-#{t.to_a[3]}-#{t.to_a[1]}-#{t.to_a[0]}.json"
    
    Dir.mkdir 'saved' unless Dir.exist? 'saved'
    File.open("saved/#{filename}", 'w') do |f|
      f.write(data)
    end

  end
  def self.load_game(filename)
    data = nil
    File.open(filename) do |f|
      data = JSON.load(f.read)
    end
    self.new(data['wrong_counter'], data['wrong_guesses'], data['correct_choices'], data['secret_word'])
  end
end

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

  game.play_choice(choice)
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
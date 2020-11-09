class Secret
  attr_reader :secret_word
  attr_accessor :wrong_counter, :wrong_guesses, :correct_choices
  def initialize(wrong_cnt=0, wrong_gsses=[], correct_chcs=[])
    @secret_word = self.select_secret_word
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
    puts "Wrong Counter: #{wrong_counter}"
    puts "Wrong Choices: #{wrong_guesses.join(", ")}"
    disp = secret_word.chars.map {|ltr| correct_choices.include?(ltr) ? ltr : "_ "}
    disp.each { |l| print l}
    puts ""    

  end

  def play_choice(char)

  end
  # def self.load_game(filename)
  # end
end

game = Secret.new
puts game.display_status
puts game.secret_word

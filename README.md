# ruby-hangman-TOP
Hangman Project from The Odin Project

## Methods

- select_secret_word()
	- must be between 5 to 12 characters long
	- must come from `5deskt.txt` file
- display_status()
	- must display count of wrong guesses
	- must display wrong letters chosen
	- must display correct letters and in their position of the secret word
- save_game()
	- before taking a turn, a player should have the option of saving the current game.
- load_game()
	- At the start of the game, the player should choose to play new game or load saved game

## chronology
1. Ask for new game or load game
2. Start playing game with `display_status`
3. accept turn
4. handle new info
5. handle win or lose
6. exit

# Objects
Due to the nature of this game, the only objects that should exists is the secret object. The game will be handled in a while loop.

## Secret Object
The secret object should have the following methods and interactions:

### Object Methods
- display_status() X
- save_game()
- select_secret_word() X
- display_secret_word() 
  - This method would be called if the game is lost
- play_choice(char) X
  - Takes in character and either puts it in wrong choices, or correct choices.
- is_complete?
  - checks to see if your correct choices are all in the secret word
  - If true then it's a win!
  
#### initialize

```Ruby
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
```

#### select_secret_word()

```Ruby
def select_secret_word
  File.open("5disk.txt", 'r') do |file|
    words = []
    until file.eof?
      word = file.readline
      if word.length >= 5 && word.length <= 12
        words.push(word)
      end
    end
    words.sample
  end
end
```

#### display_secret_word()

```Ruby
attr_reader :secret_word

def display_secret_word
  puts "#{secret_word}"
end
```

### Object Attributes
- Secret Word `@secret_word`
- Wrong guesses counter `@wrong_counter`
- Wrong Guess choices `@wrong_guesses = []`
- Correct choices `@correct_choices = []`

## Class Methods for Secret Object
- load_game()
	- creates object based on saved game


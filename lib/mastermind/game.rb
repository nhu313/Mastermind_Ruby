module Mastermind
  class Game
    
    def initialize
      @number_of_remaining_guesses = 20
      @submitted_guesses = []
    end
    
    def number_of_remaining_guesses
      @number_of_remaining_guesses
    end
    
    def submitted_guesses
      @submitted_guesses
    end
    
    def submit_guess(guess)
      if @number_of_remaining_guesses > 0
        @submitted_guesses << guess
        @number_of_remaining_guesses -= 1
      end
    end
    
  end
end
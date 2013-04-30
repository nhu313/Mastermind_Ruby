require 'mastermind/code'

module Mastermind
  class Game
    $number_of_remaining_guesses = 10
    attr_reader :number_of_remaining_guesses, :submitted_guesses
    
    def initialize(code_size=4)
      @size = code_size
      @code = Mastermind::Code.new(code_size)
      reset_game
    end
    
    def submit_guess(guess)
      results = nil
      if add_guess(guess)
        @submitted_guesses << guess
        @number_of_remaining_guesses -= 1
        results = @code.results(guess)
      end
      results
    end
    
    def add_guess(guess)
      in_progress && @submitted_guesses.include?(guess) == false
    end
    
    def reset_game
      @number_of_remaining_guesses = 5
      @submitted_guesses = []      
      @code.new_code(@size)
    end
     
    def in_progress
      return false if player_win
      return false if @number_of_remaining_guesses < 1
      
      return true
    end
    
    def player_win
      @submitted_guesses.include?(secret_code)
    end
    
    def secret_code
      @code.secret_code
    end
  end
end
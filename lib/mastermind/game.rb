module Mastermind
  class Game
    def initialize(size=5, code_generator=Mastermind::CodeGenerator.new)
      @code_generator = code_generator
      @size = size
      self.new_game
    end
    
    def secret_code
      @secret_code
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
    
    def new_game
      @number_of_remaining_guesses = 5
      @submitted_guesses = []      
      @secret_code = @code_generator.random_code(@size)
    end
  end
end
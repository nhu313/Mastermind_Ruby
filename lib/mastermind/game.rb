require 'mastermind/code'
require 'mastermind/code_factory'
require 'mastermind/game_properties'

module Mastermind
  class Game
    attr_accessor :number_of_guesses, :number_of_remaining_guesses, :size, :code_factory, :secret_code, :submitted_guesses
    
    def initialize(code_size=SIZE, number_of_guesses=NUMBER_OF_GUESSES, code_factory = Mastermind::CodeFactory.new)
      @number_of_guesses = number_of_guesses
      @size = code_size
      @code_factory = code_factory
      
      reset_game
    end
    
    def reset_game
      @number_of_remaining_guesses = number_of_guesses
      @submitted_guesses = []
      @secret_code = code_factory.random_code(size)
    end
    
    def submit_guess(guess)
      return if over?
      return if has_guess_been_submitted?(guess)
      
      submitted_guesses << guess
      @number_of_remaining_guesses -= 1
      results = secret_code.results(guess)
    end
    
    def has_guess_been_submitted?(guess)
      submitted_guesses.include?(guess)
    end
     
    def over?
      return true if has_winner?
      return true if number_of_remaining_guesses < 1
      
      return false
    end
    
    def has_winner?
      submitted_guesses.include?(secret_code)
    end
  end
end
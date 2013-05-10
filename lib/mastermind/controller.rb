require 'mastermind/game'
require 'mastermind/console'

module Mastermind
  
  class Controller
    
    attr_accessor :game, :console
    
    def initialize(game=Mastermind::Game.new, console = Mastermind::Console.new)
      @console = console
      @game = game
    end
    
    def start_game
      console.display_header(game.size)
      start_game_without_header
    end
    
    private
    
    def start_game_without_header
      game.reset_game
      take_guess until game.over?
      display_game_result
        
      start_game_without_header if console.new_game?      
    end
    
    def take_guess
      guess = console.get_user_input(game.number_of_remaining_guesses)
  
      if !correct_size?(guess)
        console.display_bad_input
      elsif game.has_guess_been_submitted?(guess)
        console.display_guess_already_submitted
      else
        submit_guess(guess)          
      end
    end
    
    def submit_guess(guess)
      result = game.submit_guess(guess)
      console.display_guess_result(result)
    end
        
    def correct_size?(guess)
      return guess && guess.size == game.size
    end
        
    def display_game_result
      if game.has_winner?
        console.display_win_message
      else
        console.display_lose_message(game.secret_code)
      end
    end

  end
  
end
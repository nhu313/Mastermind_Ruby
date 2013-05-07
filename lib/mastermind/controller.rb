require 'mastermind/game'
require 'mastermind/console'

module Mastermind
  
  class Controller
    
    attr_accessor :game, :console
    
    def initialize(game=Mastermind::Game.new, console = Mastermind::Console.new)
      @console = console
      @game = game
    end
    
    
    # # don't start a new game until the current one is over
    # console.get_valid_guess
    # console.start_a_new_game?
    # def start_a_new_game?
    #   user_input = gets.downcase.chomp
    #   user_input == 'i' || user_input == 'n'
    # end
    # console.output_header(game.size)
    
    
    def start_game
      console.display_header(game.size)
      
      new_game = true
      while(new_game)
        game.reset_game
        until game.over?
          guess = console.get_user_input(game.number_of_remaining_guesses)
      
          if is_valid_guess(guess)
            submit_guess(guess)
          else
            console.display_bad_input
          end
      
        end   
        display_game_result
        
        new_game = console.new_game?
      end
    end
    
    private
    def submit_guess(guess)
      if game.has_guess_been_submitted?(guess)
        console.display_guess_already_submitted
      else
        result = game.submit_guess(guess)
        console.display_guess_result(result)
      end
    end
        
    def is_valid_guess(guess)
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
require 'mastermind/game'
require 'mastermind/code_factory'
require 'mastermind/code_parser'
require 'mastermind/content'
require 'mastermind/result_converter'
require 'mastermind/code'

module Mastermind
  
  class Controller
    
    attr_accessor :content, :input, :output, :game, :input_parser, :result_converter
    
    def initialize(input=STDIN, output=STDOUT, game=Mastermind::Game.new)
      @input = input
      @output = output
      @game = game
      @input_parser = Mastermind::CodeParser.new
      @result_converter = Mastermind::ResultConverter.new
      @content = Mastermind::Content.new
    end
    
    def start_game
      print_header
      
      until game.over?
        output.print("\n" + content.number_of_remaining_guesses(game.number_of_remaining_guesses))
        output.print(content.input_message)
        
        user_input = input.gets
        guess = input_parser.parse(user_input)
      
        if is_valid_guess(guess)
          submit_guess(guess)
        else
          output.print(content.bad_input << "\n")
        end
      end
      
      print_game_result
    end
    
    def submit_guess(guess)
      guess_code = Mastermind::Code.new(guess)
      if game.has_guess_been_submitted?(guess_code)
        output.print(content.already_submitted_guess)            
      else
        result = game.submit_guess(guess_code)
        result_output = result_converter.to_string(result)
        output.print(result_output << "\n")
      end
    end
    
    def print_header
      output.print(content.welcome_message)
      output.print(content.result_explaination(game.size))
      output.print(content.separator)      
    end
    
    def is_valid_guess(guess)
      return guess && guess.size == @game.size
    end
        
    def print_game_result
      if game.player_win?
        output.print(content.win_message)
      else
        output.print(content.lose_message(game.secret_code.to_s))
      end
      output.print("\n")      
    end

  end
  
end
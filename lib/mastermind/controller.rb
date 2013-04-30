require 'mastermind/game'
require 'mastermind/codegenerator'
require 'mastermind/codeparser'
require 'mastermind/content'
require 'mastermind/resultconverter'
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
      
      while (game.in_progress)
        output.print("\n" + content.input_message)
        output.print(game.secret_code) #to remove
        
        user_input = input.gets
        guess = input_parser.parse(user_input)
      
        if is_valid_guess(guess)
          result = game.submit_guess(guess)
          print_submitted_guess_result(result)
        else
          output.print(content.incorrect_input)
        end
      end
      
      print_game_result
    end
    
    def is_valid_guess(guess)
      return guess && guess.size == 4
    end
    
    def print_submitted_guess_result(result)
      if (result)
        result_output = result_converter.to_string(result)
        output.print(result_output + "\n")
      else
        output.print(content.already_submitted_input)
      end
    end
    
    def print_header
      output.print(content.welcome_message)
      output.print(content.result_explaination)
      output.print(content.separator)      
    end
    
    def print_game_result
      if game.player_win
        output.print(content.win_message)
      else
        output.print(content.lose_message(game.secret_code.to_s))
      end
      output.print("\n")      
    end
    
    private 
    attr_accessor :input, :output, :game
    
  end
  
end
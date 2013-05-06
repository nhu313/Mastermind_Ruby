module Mastermind
  
  class GuessHandler
    
    def initialize(game, input_parser, content, result_converter)
      @game = game
      @input_parser = input_parser
      @content = content
      @result_converter = result_converter
    end
    
    def handle_input(input)
      guess = input_parser.parse(user_input)
      if is_valid_guess(guess)
        submit_guess(guess)
      else
        content.bad_input << "\n"
      end
      
    end
    
    def submit_guess(guess)
      guess_code = Mastermind::Code.new(guess)
      if game.has_guess_been_submitted?(guess_code)
        content.already_submitted_guess
      else
        result = game.submit_guess(guess_code)
        result_converter.to_string(result) << "\n"
      end
    end
    
    def is_valid_guess(guess)
      return guess && guess.size == @game.size
    end
  end
end
module Mastermind
  # 
  # class GuessHandler
  #   
  #   def handle_input(input) do
  #     guess = input_parser.parse(user_input)
  #   
  #     if is_valid_guess(guess)
  #       submit_guess(guess)
  #     else
  #       output.print(content.bad_input << "\n")
  #     end
  #     
  #   end
  #   
  #   def submit_guess(guess)
  #     guess_code = Mastermind::Code.new(guess)
  #     if game.has_guess_been_submitted?(guess_code)
  #       output.print(content.already_submitted_guess)            
  #     else
  #       result = game.submit_guess(guess_code)
  #       result_output = result_converter.to_string(result)
  #       output.print(result_output << "\n")
  #     end
  #   end
  #   
  #   def is_valid_guess(guess)
  #     return guess && guess.size == @game.size
  #   end
  #   
  #   
  # end
end
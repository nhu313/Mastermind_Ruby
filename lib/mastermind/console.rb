require 'mastermind/code_parser'
require 'mastermind/result_converter'
require 'mastermind/code'

module Mastermind
  
  class Console
   
   def initialize(input=STDIN, output=STDOUT, input_parser=Mastermind::CodeParser.new) 
     @input = input
     @output = output
     @input_parser = input_parser
     @result_converter = Mastermind::ResultConverter.new
   end 
   
   def display_header(size)
     output.print(welcome_message)
     output.print(result_explaination(size))
     output.print(separator)      
   end
   
   def welcome_message
     message = %Q{
     Welcome to Mastermind! The game will create a secret code with 4 numbers. The number is from 
     0-9. The object of the game is for you to solve the code in 10 guesses. The numbers can 
     repeat. After entering your guess, the system will let you know if your result is correct or not.       
     }
     
   end
   
   def result_explaination(size)
     message = %Q{
       Meaning of results: 
       'b' - correct color in correct position
       'w' - correct color but the position is incorrect
       ' ' - wrong color
     
       For example, if the code is 1, 2, 3, 4 and you enter 1, 3, 5, 5 then the result 
       will be [b w] because 
       - 1 is in the secret and the position is correct. 
       - 3 is the correct value but in the wrong position
       - 2, 4 is not in your result, so there are 2 only two result values
       
       Your guesses should have #{size} numbers from 0-9, separate by spaces.
     }
   end
   
   def separator
     "-----------------------------------------------------------\n"
   end
   
   def display_win_message
     output.print("Congratulation! You won!\n")
   end
   
   def display_lose_message(code)
     output.print("You lost! The secret code is " << code.value.to_s << "\n")
   end
   
   def get_user_input(number_of_remaining_guesses)
     output.print("You have #{number_of_remaining_guesses} guess(es) left. Please enter your guess.\n")
     user_input = input.gets
     @input_parser.parse(user_input)
   end
   
   def display_bad_input
     output.print("Unable to parse your input. Please make sure it is in the correct format.")
   end
   
   def display_guess_already_submitted
     output.print("You already submitted this guess. Please enter something else.")
   end
   
   def display_guess_result(result)
     result_output = result_converter.to_string(result)
     output.print(result_output << "\n")
   end
   
   def new_game?
     output.print("Do you want to play again? Enter 'y' for yes and 'n' for no.\n")
     user_input = input.gets
     user_input.downcase.chomp == 'y'
   end
   
   private
   attr_accessor :output, :input, :content, :result_converter
  end
end
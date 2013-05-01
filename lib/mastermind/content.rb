module Mastermind
  class Content
    
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
      
        For example, if the code is [1, 2, 3, 4] and you enter [1, 3, 5, 5] then the result 
        will be [b w] because 
        - 1 is in the secret and the position is correct. 
        - 3 is the correct value but in the wrong position
        - 2, 4 is not in your result, so there are 2 only two result values
        
        Your guesses should have #{size} numbers from 0-9, separate by spaces.
      }
    end
    
    def input_message
      message = "Please enter your guess. \n"
    end
    
    def separator
      "-----------------------------------------------------------"
    end
    
    def win_message
      "Congratulation! You won!"
    end

    def lose_message(secret_code)
      "You lost! The secret code is " << secret_code.to_s
    end
    
    def bad_input
      "Unable to parse your input. Please make sure it is in the correct format."
    end
    
    def already_submitted_guess
      "You already submitted this guess. Please enter something else."
    end
    
    def number_of_remaining_guesses(number_of_guesses)
      "You have #{number_of_guesses} guess(es) left. "
    end
  end
  
end
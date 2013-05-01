require 'mastermind/spec_helper'

describe Mastermind::Content do
  
  before(:each) do
    @content = Mastermind::Content.new
  end
  
  it "returns a welcome message" do
    @content.welcome_message.should match "Welcome to Mastermind! The game will create a secret code with 4 numbers. The number is from 
      0-9. The object of the game is for you to solve the code in 10 guesses. The numbers can 
      repeat. After entering your guess, the system will let you know if your result is correct or not."
  end
  
  it "returns a message explaining the results" do
    result_message = %Q{
      Meaning of results: 
      'b' - correct color in correct position
      'w' - correct color but the position is incorrect
      ' ' - wrong color
    
      For example, if the code is [1, 2, 3, 4] and you enter [1, 3, 5, 5] then the result 
      will be [b w] because 
      - 1 is in the secret and the position is correct. 
      - 3 is the correct value but in the wrong position
      - 2, 4 is not in your result, so there are 2 only two result values
      
      Your guesses should have 4 numbers from 0-9, separate by spaces.
    }

#    @content.result_explaination(4).should match result_message
    
  end
  
  it "returns a message asking for user input" do
    @content.input_message.should match "Please enter your guess. \n"
  end
  
  it "returns a string of separator" do
    @content.separator.should match "-----------------------------------------------------------"
  end
  
  it "returns a message letting the user knows he won" do
    @content.win_message.should match "Congratulation! You won!"
  end
  
  it "returns a message notifying the user he lost" do
    secret_code = [1, 3, 2]
    expected_message = "You lost! The secret code is " << secret_code.to_s
    #@content.lose_message(secret_code).should match expected_message
  end
  
  it "returns an incorrect input message" do
    @content.bad_input.should match "Unable to parse your input. Please make sure it is in the correct format."
  end
  
  it "returns a message noting that the user has already submitted the guess" do
    @content.already_submitted_guess.should match "You already submitted this guess. Please enter something else."
  end
  
  it "returns a number of remaining guesses" do
    number = 5
    #@content.number_of_remaining_guesses(number).should match "You have #{number} guess(es) left. "
  end
end
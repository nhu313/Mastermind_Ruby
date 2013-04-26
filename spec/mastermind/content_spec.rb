require 'mastermind/content'

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
    result_message = "Results: 
      'b' - correct color in correct position
      'w' - correct color but the position is incorrect
      ' ' - wrong color
      
      For example, if the code is [1, 2, 3, 4] and you enter [1, 3, 5, 5] then the result 
      will be [b w] because 
      - 1 is in the secret and the position is correct. 
      - 3 is the correct value but in the wrong position
      - 2, 4 is not in your result, so there are 2 only two result values"
    @content.result_explaination.should match result_message
    
  end
end
module Mastermind
  class Main
    
    def initialize(input = STDIN, output = STDOUT, size = 4)
      @input_stream = input
      @output_stream = output
      @size = size
      @game = Game.new(@size)
      @parser = CodeParser.new
      
      self.start_game
    end
    
    def start_game
      
    end
    
    def new_code_message
      "A secret code has been created. Can you figure out what it is?"
    end
    
    def welcome_message
      message = %Q{
      Welcome to Mastermind! I will create a secret code. 
      
      Please choose any 5 numbers from 0 - 9. 
      
      Results: 
      'b' - correct color in correct position
      'w' - correct color but the position is incorrect
      ' ' - wrong color
      
      For example, if the code is [1, 2, 3, 4] and you enter [1, 3, 5, 5] then the result 
      will be [b w] because 
      - 1 is in the secret and the position is correct. 
      - 3 is the correct value but in the wrong position
      - 2, 4 is not in your result, so there are 2 only two result values
      
      Let's start!
      }
    end
    
  end
end
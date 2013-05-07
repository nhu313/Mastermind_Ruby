require 'mastermind/spec_helper'

describe Mastermind::Console do
  
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @input_parser = mock(Mastermind::CodeParser)
    @console = Mastermind::Console.new(@input, @output, @input_parser)
  end
  
  it "calls content to print header" do
    game_size = 3
    @output.should_receive(:print).exactly(3).times 
    @console.display_header(game_size)
  end
  
  it "displays winning message" do
    @console.display_win_message
    @output.string.should match "Congratulation! You won!"
  end
  
  it "display losing message" do
    code = Mastermind::Code.new([1, 2, 3])
    @console.display_lose_message(code)
    @output.string.should == "You lost! The secret code is [1, 2, 3]\n"
  end
  
  it "notifies user of bad input" do
    @console.display_bad_input
    @output.string.should match "Unable to parse your input. Please make sure it is in the correct format."
  end

  it "notifies user that guess has already been submitted" do
    @console.display_guess_already_submitted
    @output.string.should match "You already submitted this guess. Please enter something else."
  end
  
  it "displays the guess results" do
    result = Mastermind::Result.new(1, 2, 1)
    
    @console.display_guess_result(result)
    @output.string.should == "[b w w]\n"
  end
  
  describe "getting user input for guess" do
  
    it "displays guesses and ask for user input" do
      number_of_remaining_guesses = 3

      message = "You have 3 guess(es) left. Please enter your guess.\n"
      @input_parser.should_receive(:parse)
      
      @console.get_user_input(number_of_remaining_guesses)
      @output.string.should == message
    end
  
    it "gets input" do
      user_input = "1 2 3"
      code = Mastermind::Code.new([1, 2, 3])
      @input.should_receive(:gets).and_return(user_input)
      @input_parser.should_receive(:parse).with(user_input).and_return(code)
      @console.get_user_input(3).should == code
    end
  end
  
  describe "user inputs for a new game" do
    it "displays a message asking if the user want to play again" do
      @input.should_receive(:gets).and_return("n")
      @console.new_game?
      @output.string.should == "Do you want to play again? Enter 'y' for yes and 'n' for no.\n"      
    end
    
    it "is true when user enters y for a new game" do
      input = "y"
      @input.should_receive(:gets).and_return(input)
      @console.new_game?.should be_true
    end
    
    it "is false when user enters n for a new game" do
      input = "n"
      @input.should_receive(:gets).and_return(input)      
      @console.new_game?.should be_false
    end
  end
  
end
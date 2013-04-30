require 'mastermind/spec_helper'

describe Mastermind::Controller do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @game = mock(Mastermind::Game)
    @controller = Mastermind::Controller.new(@input, @output, @game)
  end
  
  it "" do
    
  end
  
  it "prints a win message when the player win" do
    win_message = "winner!"
    
    @game.should_receive(:player_win).and_return(true)
    
    content = mock(Mastermind::Content)
    content.should_receive(:win_message).and_return(win_message)
    
    @controller.content = content
    @controller.print_game_result
    
    @output.string.should match (win_message + "\n")
  end
  
  it "prints a message notifying the user has lost when the player didn't win" do
    lost = "loser!"
    secret_code = Mastermind::Code.new([1, 4])
    
    @game.should_receive(:player_win).and_return(false)
    @game.should_receive(:secret_code).and_return(secret_code)
    
    content = mock(Mastermind::Content)
    content.should_receive(:lose_message).with(secret_code.to_s).and_return(lost)
    
    @controller.content = content
    @controller.print_game_result
    
    @output.string.should match (lost + "\n")
  end
  
  it "prints guess is already submitted message when the game doesn't return anything" do
   result = nil
   
   message = "already submitted guess"
   
   content = mock(Mastermind::Content)
   content.should_receive(:already_submitted_guess).and_return(message)
   @controller.content = content
   
   @controller.print_submitted_guess_result(result)
   
   @output.string.should == message
  end
  
  it "prints results" do
    result = [1, 2, 3]
   
    message = "1, 2, 3"
   
    result_converter = mock(Mastermind::ResultConverter)
    result_converter.should_receive(:to_string).with(result).and_return(message)
    @controller.result_converter = result_converter
       
    @controller.print_submitted_guess_result(result)
    
    @output.string.should == (message + "\n")
  end

  it "calls content to print header" do
    welcome_message = "welcome"
    result_explaination = "result explaination"
    separator = "---------------------"

    size = 3
    
    @game.should_receive(:size).and_return(size)

    content = mock(Mastermind::Content)
    content.should_receive(:welcome_message).and_return(welcome_message)
    content.should_receive(:result_explaination).with(size).and_return(result_explaination)
    content.should_receive(:separator).and_return(separator)
    @controller.content = content
    
    @controller.print_header
    
    @output.string.should == (welcome_message << result_explaination << separator)
  end
  
  it "returns false when guess is nil" do
    @controller.is_valid_guess(nil).should be_false
  end
  
  it "returns false when guess size is larger than game size" do
    guess = [1, 2, 3, 1, 2]
    game_size = guess.size - 1
    @game.should_receive(:size).and_return(game_size)
    
    @controller.is_valid_guess(guess).should be_false
  end
  
  it "returns false when guess size is less than game size" do
    guess = [1, 2, 3]
    game_size = guess.size + 1
    @game.should_receive(:size).and_return(game_size)
    
    @controller.is_valid_guess(guess).should be_false    
  end
  
  it "returns true when guess size is equal to game size" do
    guess = [1, 2, 3]
    game_size = guess.size
    @game.should_receive(:size).and_return(game_size)
    
    @controller.is_valid_guess(guess).should be_true   
  end
  
  
end
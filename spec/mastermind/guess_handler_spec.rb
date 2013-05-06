# require 'mastermind/spec_helper'
# 
# describe Mastermind::GuessHandler do
#   
#   before(:each) do
#     @content = mock(Mastermind::Content.new)
#     @input_parser = mock(Mastermind::InputParser.new)
#     @game = mock(Mastermind::Game.new)
#     @result_converter = mock(Mastermind::ResultConverter.new)
#     
#     @controller = Mastermind::GuessHandler.new(@game, @input_parser, @content)
#   end
#   
#   
#   describe "valid guess" do
#     it "returns false when guess is nil" do
#       @controller.is_valid_guess(nil).should be_false
#     end
#   
#     it "returns false when guess size is larger than game size" do
#       guess = [1, 2, 3, 1, 2]
#       game_size = guess.size - 1
#       @game.should_receive(:size).and_return(game_size)
#     
#       @controller.is_valid_guess(guess).should be_false
#     end
#   
#     it "returns false when guess size is less than game size" do
#       guess = [1, 2, 3]
#       game_size = guess.size + 1
#       @game.should_receive(:size).and_return(game_size)
#     
#       @controller.is_valid_guess(guess).should be_false    
#     end
#   
#     it "returns true when guess size is equal to game size" do
#       guess = [1, 2, 3]
#       game_size = guess.size
#       @game.should_receive(:size).and_return(game_size)
#     
#       @controller.is_valid_guess(guess).should be_true   
#     end
#   end
#   
#   # it "gets user inputs when game is in progress and user enters bad input" do
#   #   guess = "1 3 4"
#   #   
#   #  @game.should_receive(:over?).and_return(false, true)
#   #  @game.should_receive(:number_of_remaining_guesses).once.and_return(0)
#   #  
#   #  @input_parser.should_receive(:parse).with(guess).and_return(nil)
#   #  
#   #  @content.should_receive(:number_of_remaining_guesses).and_return("content")
#   #  @content.should_receive(:input_message).and_return("content")
#   #  @content.should_receive(:bad_input).and_return("content")
#   #  
#   #  @controller.should_receive(:print_header).once
#   #  @controller.should_receive(:print_game_result).once
#   # 
#   #  @controller.start_game
#   # end
#   # 
#   # it "gets user inputs when game is in progress and user enters good input" do
#   #   guess = "1 3 4 5"
#   #   parsed_guess = [1, 3, 4, 5]
#   #   
#   #  @game.should_receive(:over?).and_return(false, true)
#   #  @game.should_receive(:number_of_remaining_guesses).once.and_return(0)
#   #  
#   #  @input_parser.should_receive(:parse).with(guess).and_return(parsed_guess)
#   #  
#   #  @content.should_receive(:number_of_remaining_guesses).and_return("content")
#   #  @content.should_receive(:input_message).and_return("content")
#   #  
#   # 
#   #  @controller.should_receive(:print_header).once
#   #  @controller.should_receive(:print_game_result).once
#   #  @controller.should_receive(:submit_guess).with(parsed_guess).once
#   #  @controller.should_receive(:is_valid_guess).with(parsed_guess).once.and_return(true)
#   # 
#   #  @controller.start_game
#   # end
#   
#   it "prints guess is already submitted message when user submit twice" do
#     guess = [1, 9, 4]    
#     @game.should_receive(:has_guess_been_submitted?).with(Mastermind::Code.new(guess)).and_return(true)
#    
#    message = "already submitted guess"
#    
#    @content.should_receive(:already_submitted_guess).and_return(message)
#    
#    @controller.submit_guess(guess)
#    
#    @output.string.should == message
#   end
#   
#   
#   it "prints results when submit guess is successful" do
#     guess = Mastermind::Code.new([4, 3, 5])
#   
#     result = [1, 2, 3]
#     @game.should_receive(:has_guess_been_submitted?).with(guess).and_return(false)
#     @game.should_receive(:submit_guess).with(guess).and_return(result)
#   
#     result_message = "successful result"
#     @result_converter.should_receive(:to_string).with(result).and_return(result_message)
#      
#     @controller.submit_guess(guess.value)
#   
#     @output.string.should == result_message
#   end
# end
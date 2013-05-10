require 'mastermind/spec_helper'

describe Mastermind::Controller do
  before(:each) do
    @game = mock(Mastermind::Game)
    
    @console = mock(Mastermind::Console)
    @controller = Mastermind::Controller.new(@game, @console)
  end
  
  it "displays a welcome message when the game starts" do
    size = 3
    
    @game.should_receive(:over?).and_return(true)
    @game.should_receive(:size).and_return(size)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:new_game?).and_return(false)
    
    @controller.should_receive(:display_game_result)
    @controller.start_game
  end

  it "displays a winning message when user wins" do
    size = 3
    @game.should_receive(:over?).and_return(true)
    @game.should_receive(:has_winner?).and_return(true)
    @game.should_receive(:size).and_return(size)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:display_win_message)
    @console.should_receive(:new_game?).and_return(false)
    
    @controller.start_game
  end
  
  it "display a losing message when user lose" do
    size = 3
    secret_code = Mastermind::Code.new([4, 4, 4])
    @game.should_receive(:over?).and_return(true)
    @game.should_receive(:has_winner?).and_return(false)
    @game.should_receive(:size).and_return(size)
    @game.should_receive(:secret_code).and_return(secret_code)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:display_lose_message).with(secret_code)
    @console.should_receive(:new_game?).and_return(false)
    
    @controller.start_game
  end
  
  it "displays a message notifying the user entered bad input when user did not enter anything" do
    size = 3
    number_of_remaining_guesses = 4
    @game.should_receive(:over?).and_return(false, true)
    @game.should_receive(:size).and_return(size)
    @game.should_receive(:has_winner?).and_return(true)
    @game.should_receive(:number_of_remaining_guesses).and_return(number_of_remaining_guesses)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:display_win_message)
    @console.should_receive(:get_user_input).with(number_of_remaining_guesses).and_return(nil)
    @console.should_receive(:display_bad_input)
    @console.should_receive(:new_game?).and_return(false)

    @controller.start_game
  end
  
  it "displays a message notifying the user entered bad input when the input does not match the game code size" do
    size = 10
    guess = Mastermind::Code.new([4, 4, 4])
    number_of_remaining_guesses = 4
    @game.should_receive(:over?).and_return(false, true)
    @game.should_receive(:size).exactly(2).times.and_return(size)
    @game.should_receive(:has_winner?).and_return(true)
    @game.should_receive(:number_of_remaining_guesses).and_return(number_of_remaining_guesses)
    @console.should_receive(:new_game?).and_return(false)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:display_win_message)
    @console.should_receive(:get_user_input).with(number_of_remaining_guesses).and_return(guess)
    @console.should_receive(:display_bad_input)

    @controller.start_game
  end
  
  it "submits the user guess when user input is good" do
    guess = Mastermind::Code.new([4, 4, 4])
    size = guess.size
    number_of_remaining_guesses = 4
    result = Mastermind::Result.new(1, 1, 1)
    
    @game.should_receive(:over?).and_return(false, true)
    @game.should_receive(:size).exactly(2).times.and_return(size)
    @game.should_receive(:has_winner?).and_return(true)
    @game.should_receive(:number_of_remaining_guesses).and_return(number_of_remaining_guesses)
    @game.should_receive(:has_guess_been_submitted?).and_return(false)
    @game.should_receive(:submit_guess).with(guess).and_return(result)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:display_win_message)
    @console.should_receive(:get_user_input).with(number_of_remaining_guesses).and_return(guess)
    @console.should_receive(:display_guess_result).with(result)
    @console.should_receive(:new_game?).and_return(false)

    @controller.start_game
  end
  
  it "notifies the user when the guess has already been submitted" do
    guess = Mastermind::Code.new([4, 4, 4])
    size = guess.size
    number_of_remaining_guesses = 4
    result = Mastermind::Result.new(1, 1, 1)
    
    @game.should_receive(:over?).and_return(false, true)
    @game.should_receive(:size).exactly(2).times.and_return(size)
    @game.should_receive(:has_winner?).and_return(true)
    @game.should_receive(:number_of_remaining_guesses).and_return(number_of_remaining_guesses)
    @game.should_receive(:has_guess_been_submitted?).and_return(true)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:display_win_message)
    @console.should_receive(:get_user_input).with(number_of_remaining_guesses).and_return(guess)
    @console.should_receive(:display_guess_already_submitted)
    @console.should_receive(:new_game?).and_return(false)

    @controller.start_game
    
  end
  
  it "stops the application when user doesn't want a new game" do
    size = 3
    @game.should_receive(:over?).and_return(true)
    @game.should_receive(:size).and_return(size)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:new_game?).and_return(false)
    
    @controller.should_receive(:display_game_result)
    @controller.start_game
  end 
  
  it "starts another game when user wants a new game" do
    size = 3
    @game.should_receive(:over?).at_least(1).and_return(true)
    @game.should_receive(:size).at_least(1).and_return(size)
    @game.should_receive(:reset_game).at_least(1)
    
    @console.should_receive(:display_header).with(size)
    @console.should_receive(:new_game?).and_return(true, false)
    
    @controller.should_receive(:display_game_result).at_least(1)
    @controller.start_game 
  end
end
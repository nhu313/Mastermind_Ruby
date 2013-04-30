require 'mastermind/spec_helper'

describe Mastermind::Game do
  $number_of_guesses = 5
  $size = 3
  
  before(:each) do
    @game = Mastermind::Game.new($size, $number_of_guesses)
  end
    
  it "starts with 5 guesses remaining" do
    @game.number_of_remaining_guesses.should == $number_of_guesses
  end
  
  it "uses a guess when submitting a guess" do
    @game.submit_guess(Mastermind::Code.new([]))
    @game.number_of_remaining_guesses.should == $number_of_guesses - 1
  end
  
  it "does nothing when number of remaining guess is 0" do
    0.upto($number_of_guesses) do |i|
      @game.submit_guess(Mastermind::Code.new([i]))
    end
    @game.number_of_remaining_guesses.should == 0    
    @game.submit_guess(Mastermind::Code.new([4]))
    
    @game.number_of_remaining_guesses.should == 0
  end
  
  it "remembers my first guess" do
    guess = Mastermind::Code.new([1,4])
    @game.submit_guess(guess)
    @game.submitted_guesses.should == [guess]
  end
  
  it "remembers all my guess" do
    guesses = [Mastermind::Code.new([1,2]), 
              Mastermind::Code.new([4,9]), 
              Mastermind::Code.new([6, 9, 1])]
    guesses.each do |guess|
      @game.submit_guess(guess)
    end
    
    @game.submitted_guesses.should == guesses
  end
  
  it "stops taking guesses when number of remaining guess is 0" do
    guesses = []
    (0...$number_of_guesses).each do |i|
      guess = Mastermind::Code.new([i])
      @game.submit_guess(guess)
      guesses << guess
    end
    @game.submit_guess(Mastermind::Code.new([1,2]))
    
    @game.submitted_guesses.should ==  guesses
  end
  
  it "tests attributes are set to default when reset is called" do
    secret_code_before_new_game = Mastermind::Code.new([1, 2, 3])
    secret_code_after_new_game = Mastermind::Code.new([5, 3, 5])
    
    @game = Mastermind::Game.new($size, $number_of_guesses, mock_code_factory(secret_code_before_new_game, secret_code_after_new_game))
    
    @game.submit_guess(Mastermind::Code.new([4]))
    
    @game.reset_game
    
    @game.number_of_remaining_guesses.should == $number_of_guesses
    @game.secret_code.should == secret_code_after_new_game
    @game.submitted_guesses.should == []

  end
  
  def mock_code_factory(before_code, after_code)
    code_factory = mock(Mastermind::CodeFactory)
    code_factory.should_receive(:random_code).with($size).and_return(before_code, after_code)
    code_factory
  end
  
  it "checks if the game is in progress when the secret code has already been submitted" do
   @game.in_progress.should be_true
   @game.submit_guess(@game.secret_code)
   @game.in_progress.should be_false
  end
  
  it "returns true if the player broke the code" do
    @game.player_win.should be_false
    @game.submit_guess(@game.secret_code)
    @game.player_win.should be_true
  end
  
  it "returns false if the player didn't submit a correct answer" do
    @game.secret_code = Mastermind::Code.new([1, 1])
    guess = Mastermind::Code.new([5,3])
    @game.submit_guess(guess)
    @game.player_win.should be_false
  end
  
  it "doesn't decrement the guess count when user submit the same guess twice" do
    guess = Mastermind::Code.new([1, 2])
    @game.submit_guess(guess)
    @game.submit_guess(guess)
    @game.number_of_remaining_guesses.should == $number_of_guesses - 1
  end
end
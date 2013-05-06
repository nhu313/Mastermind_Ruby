require 'mastermind/spec_helper'

describe Mastermind::Game do
  
  before(:each) do
    @number_of_guesses = 5
    @size = 3
    @game = Mastermind::Game.new(@size, @number_of_guesses)
  end
  
  describe "initial state" do
    it "tests the default game size is the same on the one in the property file" do
      @game = Mastermind::Game.new
      @game.size.should == Mastermind::Game::SIZE
      @game.number_of_remaining_guesses.should == Mastermind::Game::NUMBER_OF_GUESSES
    end
    
    it "starts with 5 guesses remaining" do
      @game.number_of_remaining_guesses.should == @number_of_guesses
    end
  end
  
  describe "number of remaining guesses" do
    it "uses a guess when submitting a guess" do
      @game.submit_guess(Mastermind::Code.new([]))
      @game.number_of_remaining_guesses.should == @number_of_guesses - 1
    end
  
    it "does nothing when number of remaining guess is 0" do
      @number_of_guesses.times do |i| # loops 0 through 4
        # (0..@number_of_guesses).each do |i| # loops 0 through 5
        # (0...@number_of_guesses).each do |i| # loops 0 through 4
        # 0.upto(@number_of_guesses) do |i| # loops 0 through 5
        @game.submit_guess(Mastermind::Code.new([i]))
      end
      @game.number_of_remaining_guesses.should == 0    
      @game.submit_guess(Mastermind::Code.new([4]))
    
      @game.number_of_remaining_guesses.should == 0
    end  
    
    it "doesn't decrement the guess count when user submit the same guess twice" do
      guess = Mastermind::Code.new([1, 2])
      @game.submit_guess(guess)
      @game.submit_guess(guess)
      @game.number_of_remaining_guesses.should == @number_of_guesses - 1
    end
  end

  describe "guess history" do
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
      (0...@number_of_guesses).each do |i|
        guess = Mastermind::Code.new([i])
        @game.submit_guess(guess)
        guesses << guess
      end
      @game.submit_guess(Mastermind::Code.new([1,2]))
    
      @game.submitted_guesses.should ==  guesses
    end
    
    it "returns true when user submit a guess twice" do
      guess = Mastermind::Code.new([1, 2])
      @game.submit_guess(guess)
      @game.has_guess_been_submitted?(guess).should be_true
    end
  
    it "returns false when asked if a guess has been submit when it hasn't" do
      guess = Mastermind::Code.new([1, 2])
      @game.has_guess_been_submitted?(guess).should be_false
    end
  end
  
  describe "when resetting the game" do
    before(:each) do
      secret_code_before_new_game = Mastermind::Code.new([1, 2, 3])
      @secret_code_after_new_game = Mastermind::Code.new([5, 3, 5])
    
      @game = Mastermind::Game.new(@size, @number_of_guesses, mock_code_factory(secret_code_before_new_game, @secret_code_after_new_game))
    end
    
    it "clears the submitted guesses" do    
      @game.submit_guess(Mastermind::Code.new([4]))
      @game.reset_game
    
      @game.submitted_guesses.should == []
    end
    
    it "resets the number of remaining guesses" do    
      @game.submit_guess(Mastermind::Code.new([4]))
      @game.reset_game
    
      @game.number_of_remaining_guesses.should == @number_of_guesses
    end
    
    it "generates a new secret code" do    
      @game.reset_game
    
      @game.secret_code.should == @secret_code_after_new_game
    end
  end
  
  def mock_code_factory(before_code, after_code)
    code_factory = mock(Mastermind::CodeFactory)
    code_factory.should_receive(:random_code).with(@size).and_return(before_code, after_code)
    code_factory
    
    # mock(Mastermind::CodeFactory, :random_code => only_code) # N/A here because only handles one return value
  end
  
  describe "game over" do
    it "checks if the game is over when the secret code has already been submitted" do
      @game.should_not be_over
      @game.submit_guess(@game.secret_code)
      @game.should be_over
    end
    
    it "checks if the game is over when user maxed out the number of guess" do
      (0...@number_of_guesses).each do |i|
        guess = Mastermind::Code.new([i])
        @game.submit_guess(guess)
      end    
      @game.should be_over
    end
  end
  
  describe "checks if user wins" do
    it "returns true if the player broke the code" do
      @game.should_not have_winner
      @game.submit_guess(@game.secret_code)
      @game.should have_winner
    end

    it "returns false if the player didn't submit a correct answer" do
      @game.secret_code = Mastermind::Code.new([1, 1])
      guess = Mastermind::Code.new([5,3])
      @game.submit_guess(guess)
      @game.has_winner?.should be_false
    end
  end
end
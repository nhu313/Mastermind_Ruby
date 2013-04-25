require 'mastermind/game' # require <projectroot>/lib/mastermind/game.rb

describe Mastermind::Game do
  before(:each) do
    @game = Mastermind::Game.new
  end
  
  it "starts with 20 guesses remaining" do
    @game.number_of_remaining_guesses.should == 20
  end
  
  it "uses a guess when submitting a guess" do
    @game.submit_guess("some guess")
    @game.number_of_remaining_guesses.should == 19
  end
  
  it "does nothing when number of remaining guess is 0" do
    0.upto(20) do
      @game.submit_guess("guess")
    end
    @game.number_of_remaining_guesses.should == 0    
    @game.submit_guess("guess")
    
    @game.number_of_remaining_guesses.should == 0
  end
  
  it "remembers my first guess" do
    guess = [1,4]
    @game.submit_guess(guess)
    @game.submitted_guesses.should == [guess]
  end
  
  it "remembers all my guess" do
    guesses = [[1,2], [4,9], [6, 9, 1]]
    guesses.each do |guess|
      @game.submit_guess(guess)
    end
    
    @game.submitted_guesses.should == guesses
  end
  
  it "stops taking guesses when number of remaining guess is 0" do
    guesses = [[3,5]]*20
    guesses.each do |guess|
      @game.submit_guess(guess)
    end
    @game.submit_guess([1,2])
    
    @game.submitted_guesses.should ==  guesses
  end
end
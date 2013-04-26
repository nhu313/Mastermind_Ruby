require 'mastermind/main'

describe Mastermind::Main do

  it "prints a greeting message at start up" do
    input = StringIO.new
    game = Mastermind::Main.new(input)    
    
    #input.string.should match "secret code"
  end
  
end
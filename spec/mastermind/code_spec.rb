require 'mastermind/spec_helper'

describe Mastermind::Code do  
  it "counts the exact match when all peg matches with only one peg" do
    guess = Mastermind::Code.new([1])
    secret_code = Mastermind::Code.new([1])
    
    results = Mastermind::Result.new(guess.size, 0, 0)

    secret_code.results(guess).should == results
  end
    
  it "counts the exact match when all pegs match with more than one peg" do
    guess = Mastermind::Code.new([2, 5, 7])
    secret_code = Mastermind::Code.new([2, 5, 7])
    results = Mastermind::Result.new(guess.size, 0, 0)
    
    secret_code.results(guess).should == results
  end
  
  it "counts the exact match when no peg matches for one peg" do
    guess = Mastermind::Code.new([3])
    secret_code = Mastermind::Code.new([1])
    results = Mastermind::Result.new(0, 0, guess.size)
    secret_code.results(guess).should == results
  end
  
  it "counts the exact match when no peg matches with more than one peg" do
    guess = Mastermind::Code.new([1, 9, 11, 15])
    secret_code = Mastermind::Code.new([2, 4, 6, 8])
    results = Mastermind::Result.new(0, 0, guess.size)
    secret_code.results(guess).should == results
  end
  
  it "counts the exact match when 1 peg matches the number and position" do
    guess = Mastermind::Code.new([1, 2])
    secret_code = Mastermind::Code.new([3, 2])
    results = Mastermind::Result.new(1, 0, 1)
    secret_code.results(guess).should == results
  end
  
  it "counts the exact match when 1+ pegs match the number and position" do
    guess = Mastermind::Code.new([1, 5, 3, 7, 4])
    secret_code = Mastermind::Code.new([1, 2, 3, 7, 9])
    results = Mastermind::Result.new(3, 0, 2)
    secret_code.results(guess).should == results
  end
  
  it "counts match in wrong position for one peg" do
    guess = Mastermind::Code.new([1, 2])
    secret_code = Mastermind::Code.new([2, 3])
    results = Mastermind::Result.new(0, 1, 1)
    secret_code.results(guess).should == results
  end
  
  it "counts match in wrong position for 1+ pegs" do
    guess = Mastermind::Code.new([11, 7, 18, 1, 3, 2, 21])
    secret_code = Mastermind::Code.new([21, 2, 3, 5, 9, 18, 11])
    results = Mastermind::Result.new(0, 5, 2)
    secret_code.results(guess).should == results
  end
  
  it "counts match in wrong position when all pegs match" do
    guess = Mastermind::Code.new([2, 3])
    secret_code = Mastermind::Code.new([3, 2])
    results = Mastermind::Result.new(0, guess.size, 0)
    secret_code.results(guess).should == results
  end
  
  it "counts match in the wrong position when there are two matches of the same number" do
    guess = Mastermind::Code.new([1, 1, 4, 5])
    secret_code = Mastermind::Code.new([3, 6, 1, 1])
    results = Mastermind::Result.new(0, 2, 2)
    secret_code.results(guess).should == results
  end
  
  it "counts match in the wrong position when there are 2 matches of 2 numbers" do
    guess = Mastermind::Code.new([1, 1, 1, 2, 2])
    secret_code = Mastermind::Code.new([2, 2, 2, 1, 1])
    results = Mastermind::Result.new(0, 4, 1)
    secret_code.results(guess).should == results
  end
  
  it "counts results correctly when all pegs match" do
    guess = Mastermind::Code.new([1, 1])
    secret_code = Mastermind::Code.new([1, 1])
    results = Mastermind::Result.new(guess.size, 0, 0)
    secret_code.results(guess).should == results
  end
  
  it "counts reults correctly when all pegs are incorrect" do
    guess = Mastermind::Code.new((1..10).to_a)
    secret_code = Mastermind::Code.new((11..20).to_a)
    results = Mastermind::Result.new(0, 0, secret_code.size)
    secret_code.results(guess).should == results
  end
  
  it "counts results correctly when all pegs are in the wrong position" do
    guess = Mastermind::Code.new([1, 2, 3, 4])
    secret_code = Mastermind::Code.new([4, 3, 2, 1])
    results = Mastermind::Result.new(0, guess.size, 0)
    secret_code.results(guess).should == results
  end
  
  it "counts results correctly when there exact match, wrong position, and incorrect pegs" do
    guess = Mastermind::Code.new([1, 2, 3, 4])
    secret_code = Mastermind::Code.new([4, 2, 7, 8])
    results = Mastermind::Result.new(1, 1, 2)
    secret_code.results(guess).should == results
  end
  
  it "returns the values of the code on to_s" do
    code = [1, 4, 5]
    secret_code = Mastermind::Code.new(code)
    secret_code.to_s.should == code.to_s
  end
end
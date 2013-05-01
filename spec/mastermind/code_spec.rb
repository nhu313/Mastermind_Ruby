require 'mastermind/spec_helper'

describe Mastermind::Code do      

  it "counts the exact match when all pegs match with more than one peg" do
    @guess = [2, 5, 7]
    @secret = [2, 5, 7]
    @results = [@guess.size, 0, 0]
    test_results
  end
  
  it "counts the exact match when no peg matches for one peg" do
    @guess = [3]
    @secret = [1]
    @results = [0, 0, @guess.size]
    test_results
  end
  
  it "counts the exact match when no peg matches with more than one peg" do
    @guess = [1, 9, 11, 15]
    @secret = [2, 4, 6, 8]
    @results = [0, 0, @guess.size]
    test_results
  end
  
  it "counts the exact match when 1 peg matches the number and position" do
    @guess = [1, 2]
    @secret = [3, 2]
    @results = [1, 0, 1]
    test_results
  end
  
  it "counts the exact match when 1+ pegs match the number and position" do
    @guess = [1, 5, 3, 7, 4]
    @secret = [1, 2, 3, 7, 9]
    @results = [3, 0, 2]
    test_results
  end
  
  it "counts match in wrong position for one peg" do
    @guess = [1, 2]
    @secret = [2, 3]
    @results = [0, 1, 1]
    test_results
  end
  
  it "counts match in wrong position for 1+ pegs" do
    @guess = [11, 7, 18, 1, 3, 2, 21]
    @secret = [21, 2, 3, 5, 9, 18, 11]
    @results = [0, 5, 2]
    test_results
  end
  
  it "counts match in wrong position when all pegs match" do
    @guess = [2, 3]
    @secret = [3, 2]
    @results = [0, @guess.size, 0]
    test_results
  end
  
  it "counts match in the wrong position when there are two matches of the same number" do
    @guess = [1, 1, 4, 5]
    @secret = [3, 6, 1, 1]
    @results = [0, 2, 2]
    test_results
  end
  
  it "counts match in the wrong position when there are 2 matches of 2 numbers" do
    @guess = [1, 1, 1, 2, 2]
    @secret = [2, 2, 2, 1, 1]
    @results = [0, 4, 1]
    test_results
  end
  
  it "counts results correctly when all pegs match" do
    @guess = [1, 1]
    @secret = [1, 1]
    @results = [@guess.size, 0, 0]
    test_results
  end
  
  it "counts reults correctly when all pegs are incorrect" do
    @guess = (1..10).to_a
    @secret = (11..20).to_a
    @results = [0, 0, @secret.size]
    test_results
  end
  
  it "counts results correctly when all pegs are in the wrong position" do
    @guess = [1, 2, 3, 4]
    @secret = [4, 3, 2, 1]
    @results = [0, @guess.size, 0]
    test_results
  end
  
  it "counts results correctly when there exact match, wrong position, and incorrect pegs" do
    @guess = [1, 2, 3, 4]
    @secret = [4, 2, 7, 8]
    @results = [1, 1, 2]
    test_results
  end
  
  def test_results
    guess_code = Mastermind::Code.new(@guess)
    secret_code = Mastermind::Code.new(@secret)
    expected_results = Mastermind::Result.new(@results[0], @results[1], @results[2])
    
    secret_code.results(guess_code).should == expected_results
  end
  
  it "returns the values of the code on to_s" do
    code = [1, 4, 5]
    secret_code = Mastermind::Code.new(code)
    secret_code.to_s.should == code.to_s
  end
  
  it "returns true when the value of the codes are equal" do
    value = [7, 4, 1]
    code1 = Mastermind::Code.new(value)
    code2 = Mastermind::Code.new(value)
    
    (code1 == code2).should be_true
  end
  
  it "returns false when code values are not equal" do
    code1 = Mastermind::Code.new([7, 4, 1])
    code2 = Mastermind::Code.new([7, 4, 11])
    
    (code1 == code2).should be_false
  end
end
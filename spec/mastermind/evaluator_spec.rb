require 'mastermind/evaluator'

describe Mastermind::Evaluator do
  
  before(:each) do
    @evaluator = Mastermind::Evaluator.new
  end
  
  it "counts the exact match when all peg matches with one peg" do
    guess = [1]
    secret_code = [1]
    @evaluator.count_exact_match(secret_code, guess).should == guess.size
  end
  
  it "counts the exact match when all pegs match with more than one peg" do
    guess = [2, 5, 7]
    secret_code = [2, 5, 7]
    @evaluator.count_exact_match(secret_code, guess).should == guess.size
  end
  
  it "counts the exact match when no peg matches for one" do
    guess = [3]
    secret_code = [1]
    @evaluator.count_exact_match(secret_code, guess).should == 0
  end
  
  it "counts the exact match when no peg matches with more than one" do
    guess = [1, 9, 11, 15]
    secret_code = [2, 4, 6, 8]
    @evaluator.count_exact_match(secret_code, guess).should == 0
  end
  
  it "counts the exact match when 1 peg matches the number and position" do
    guess = [1, 2]
    secret_code = [3, 2]
    @evaluator.count_exact_match(secret_code, guess).should == 1
  end
  
  it "counts the exact match when 1+ pegs match the number and position" do
    guess = [1, 5, 3, 7, 4]
    secret_code = [1, 2, 3, 7, 9]
    @evaluator.count_exact_match(secret_code, guess).should == 3
  end
  
  it "counts match in wrong position for one peg" do
    guess = [1, 2]
    secret_code = [2, 3]
    @evaluator.count_incorrect_position_match(secret_code, guess).should == 1
  end
  
  it "counts match in wrong position for 1+ pegs" do
    guess = [11, 7, 18, 1, 3, 2, 21]
    secret_code = [21, 2, 3, 5, 9, 18, 11]
    @evaluator.count_incorrect_position_match(secret_code, guess).should == 5
  end
  
  it "counts match in wrong position when all pegs match" do
    guess = [2, 3]
    secret_code = [3, 2]
    @evaluator.count_incorrect_position_match(secret_code, guess).should == 2
  end
  
  it "counts match in the wrong position when there are two matches of the same number" do
    guess = [1, 1, 4, 5]
    secret_code = [3, 6, 1, 1]
    @evaluator.count_incorrect_position_match(secret_code, guess).should == 2
  end
  
  it "counts match in the wrong position when there are 2 matches of 2 numbers" do
    guess = [1, 1, 1, 2, 2]
    secret_code = [2, 2, 2, 1, 1]
    @evaluator.count_incorrect_position_match(secret_code, guess).should == 4
  end
  
  it "evaluates guess correctly when all pegs match" do
    guess = [1, 1]
    secret_code = [1, 1]
    @evaluator.evaluate(secret_code, guess).should == [2, 0, 0]
  end
  
  it "evaluates guess correctly when all pegs are incorrect" do
    guess = (1..10).to_a
    secret_code = (11..13).to_a
    @evaluator.evaluate(secret_code, guess).should == [0, 0, secret_code.size]
  end
  
  it "evaluates guess correctly when all pegs are in the wrong position" do
    guess = [1, 2, 3, 4]
    secret_code = [4, 3, 2, 1]
    @evaluator.evaluate(secret_code, guess).should == [0, secret_code.size, 0]
  end
  
  it "evaluates guess correctly when there all exact match, wrong position, and incorrect pegs" do
    guess = [1, 2, 3, 4]
    secret_code = [4, 2, 7, 8]
    @evaluator.evaluate(secret_code, guess).should == [1, 1, 2]
  end
end
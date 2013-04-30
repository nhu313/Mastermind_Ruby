require 'mastermind/code'
require 'mastermind/codegenerator'

describe Mastermind::Code do
  # before(:each) do
  #   @code_generator = mock(Mastermind::CodeGenerator)
  #   @code = Mastermind::Code.new(1, )
  #   @code.code_generator = @code_generator
  # end

  def test_results(secret_code, guess, results)
    code = code_with_mock_generator(secret_code)
    code.results(guess).should == results    
  end
  
  def code_with_mock_generator(secret_code)
    code_generator = mock(Mastermind::CodeGenerator)
    code_generator.should_receive(:random_code).with(secret_code.size).and_return(secret_code)
    
    Mastermind::Code.new(secret_code.size, code_generator)
  end
  
  it "counts the incorrect position match" do
    guess = [1, 2]
    secret_code = [2, 3]
    
    code_generator = mock(Mastermind::CodeGenerator)
    code_generator.should_receive(:random_code).with(secret_code.size).and_return(secret_code)
    
    code = Mastermind::Code.new(secret_code.size, code_generator)
    code.count_incorrect_position_match(guess).should == 1
  end

  it "counts the exact match when all peg matches with only one peg" do
    guess = [1]
    secret_code = [1]
    results = Mastermind::Result.new(guess.size, 0, 0)
    test_results(secret_code, guess, results)
  end
    
  it "counts the exact match when all pegs match with more than one peg" do
    guess = [2, 5, 7]
    secret_code = [2, 5, 7]
    results = Mastermind::Result.new(guess.size, 0, 0)
    test_results(secret_code, guess, results)
  end
  
  it "counts the exact match when no peg matches for one peg" do
    guess = [3]
    secret_code = [1]
    results = Mastermind::Result.new(0, 0, guess.size)
    test_results(secret_code, guess, results)
  end
  
  it "counts the exact match when no peg matches with more than one peg" do
    guess = [1, 9, 11, 15]
    secret_code = [2, 4, 6, 8]
    results = Mastermind::Result.new(0, 0, guess.size)
    test_results(secret_code, guess, results)
  end
  
  it "counts the exact match when 1 peg matches the number and position" do
    guess = [1, 2]
    secret_code = [3, 2]
    results = Mastermind::Result.new(1, 0, 1)
    test_results(secret_code, guess, results)
  end
  
  it "counts the exact match when 1+ pegs match the number and position" do
    guess = [1, 5, 3, 7, 4]
    secret_code = [1, 2, 3, 7, 9]
    results = Mastermind::Result.new(3, 0, 2)
    test_results(secret_code, guess, results)
  end
  
  it "counts match in wrong position for one peg" do
    guess = [1, 2]
    secret_code = [2, 3]
    results = Mastermind::Result.new(0, 1, 1)
    test_results(secret_code, guess, results)
  end
  
  it "counts match in wrong position for 1+ pegs" do
    guess = [11, 7, 18, 1, 3, 2, 21]
    secret_code = [21, 2, 3, 5, 9, 18, 11]
    results = Mastermind::Result.new(0, 5, 2)
    test_results(secret_code, guess, results)
  end
  
  it "counts match in wrong position when all pegs match" do
    guess = [2, 3]
    secret_code = [3, 2]
    results = Mastermind::Result.new(0, guess.size, 0)
    test_results(secret_code, guess, results)
  end
  
  it "counts match in the wrong position when there are two matches of the same number" do
    guess = [1, 1, 4, 5]
    secret_code = [3, 6, 1, 1]
    results = Mastermind::Result.new(0, 2, 2)
    test_results(secret_code, guess, results)
  end
  
  it "counts match in the wrong position when there are 2 matches of 2 numbers" do
    guess = [1, 1, 1, 2, 2]
    secret_code = [2, 2, 2, 1, 1]
    results = Mastermind::Result.new(0, 4, 1)
    test_results(secret_code, guess, results)
  end
  
  it "counts results correctly when all pegs match" do
    guess = [1, 1]
    secret_code = [1, 1]
    results = Mastermind::Result.new(guess.size, 0, 0)
    test_results(secret_code, guess, results)
  end
  
  it "counts reults correctly when all pegs are incorrect" do
    guess = (1..10).to_a
    secret_code = (11..20).to_a
    results = Mastermind::Result.new(0, 0, secret_code.size)
    test_results(secret_code, guess, results)
  end
  
  it "counts results correctly when all pegs are in the wrong position" do
    guess = [1, 2, 3, 4]
    secret_code = [4, 3, 2, 1]
    results = Mastermind::Result.new(0, guess.size, 0)
    test_results(secret_code, guess, results)
  end
  
  it "counts results correctly when there all exact match, wrong position, and incorrect pegs" do
    guess = [1, 2, 3, 4]
    secret_code = [4, 2, 7, 8]
    results = Mastermind::Result.new(1, 1, 2)
    test_results(secret_code, guess, results)
  end
end
require 'mastermind/spec_helper'

describe Mastermind::Code do      

  def results_for(array_one, array_two)
    code_one = Mastermind::Code.new(array_one)
    code_two = Mastermind::Code.new(array_two)
    code_one.results(code_two)
  end

  before(:each) do
    @secret_values = [2, 5, 7]
  end

  describe "the number of pegs that match exactly" do
    it "is the size of the code when all pegs match exactly" do
      results_for(@secret_values, [2, 5, 7]).exact_match.should == 3
    end
    
    it "is 0 when there is no exact match and all other pegs are incorrect" do
      results_for(@secret_values, [1, 1, 1]).exact_match.should == 0
    end
    
    it "is 0 when there is no exact match and all other pegs are in the wrong position" do
      results_for(@secret_values, [7, 2, 5]).exact_match.should == 0
    end
    
    it "is 1 when the only exact match is in the first peg" do
      results_for(@secret_values, [2, 1, 1]).exact_match.should == 1
    end
    
    it "is 1 when the only exact match is in the middle peg" do
      results_for(@secret_values, [1, 5, 1]).exact_match.should == 1
    end
    
    it "is 1 when the only exact match is the last peg of the code" do
      results_for(@secret_values, [1, 1, 7]).exact_match.should == 1
    end
    
    it "is 2 when there are 2 exact match" do
      results_for(@secret_values, [2, 5, 1])
    end
  end
  
  describe "the number of pegs that are in the incorrect position" do
    it "is 0 when all the pegs match" do
      results_for(@secret_values, [2, 5, 7]).incorrect_position_match.should == 0
    end
    
    it "is 0 when none of the pegs match" do
      results_for(@secret_values, [1, 1, 1]).incorrect_position_match.should == 0
    end
    
    it "is 1 when 1 peg matches the position and all the other pegs are incorrect" do
      results_for(@secret_values, [5, 1, 1]).incorrect_position_match.should == 1
    end
    
    it "is 2 when 2 pegs match the position and all the other peg is in incorrect" do
      results_for(@secret_values, [5, 7, 1]).incorrect_position_match.should == 2
    end
    
    it "is the size of the code when all pegs match but are in the incorrect positions" do
      results_for(@secret_values, [7, 2, 5]).incorrect_position_match.should == 3
    end
  end
  
  describe "test no match" do
    it "is 0 when all pegs match" do
      results_for(@secret_values, [2, 5, 7]).no_match.should == 0
    end
    
    it "is the size of the code when none of the pegs match" do
      results_for(@secret_values, [1, 1, 1]).no_match.should == 3
    end
    
    it "is 1 when 1 peg is incorrect and all the other pegs are exact match" do
      results_for(@secret_values, [1, 5, 7]).no_match.should == 1
    end
    
    it "is 1 when 1 peg is incorrect and all the other pegs are in the wrong position" do
      results_for(@secret_values, [1, 7, 5]).no_match.should == 1
    end
    
    it "is 2 when 2 pegs are incorrect and 1 is an exact match" do
      results_for(@secret_values, [1, 1, 7]).no_match.should == 2
    end
  end
  
  describe "counts for match, incorrect position, and no match" do    
    
    it "counts match in the wrong position when there are two matches of the same number" do
      guess = [1, 1, 4, 5]
      secret_values = [3, 6, 1, 1]
      results = results_for(secret_values, guess)
      results.exact_match.should == 0
      results.incorrect_position_match.should == 2
      results.no_match == 2
    end
  
    it "counts match in the wrong position when there are 3 pegs of the same number but the guess has 2 pegs" do
      guess = [1, 1, 1, 2, 2]
      secret_values = [2, 2, 2, 1, 1]
      results = results_for(secret_values, guess)
      results.exact_match.should == 0
      results.incorrect_position_match.should == 4
      results.no_match == 1
    end
    
    it "counts results correctly when there exact match, wrong position, and incorrect pegs" do
      guess = [1, 2, 3, 4]
      secret_values = [4, 2, 7, 8]
      results = results_for(secret_values, guess)
      results.exact_match.should == 1
      results.incorrect_position_match.should == 1
      results.no_match == 2
    end
  end
  
  describe "code equality" do
    it "is true when the code values are the same" do
      value = [7, 4, 1]
      code1 = Mastermind::Code.new(value)
      code2 = Mastermind::Code.new(value)
    
      (code1 == code2).should be_true
    end
  
    it "is false when the code values do not match exactly" do
      code1 = Mastermind::Code.new([7, 4, 1])
      code2 = Mastermind::Code.new([7, 4, 11])
    
      (code1 == code2).should be_false
    end
  end
end
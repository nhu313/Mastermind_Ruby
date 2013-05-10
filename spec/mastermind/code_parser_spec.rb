require 'mastermind/spec_helper'

describe Mastermind::CodeParser do
  before(:each) do
    @parser = Mastermind::CodeParser.new
  end
  
  describe "parse good input" do
    it "parses correct code input" do
      input = "0 1 2 3 4"
      @parser.parse(input).should == Mastermind::Code.new([0, 1, 2, 3, 4])
    end

    it "parses input with extra space in the front and at the end" do
      input = "   0 1   2 3   "
      @parser.parse(input).should == Mastermind::Code.new([0, 1, 2, 3])
    end
  end

  describe "parse bad input" do
    it "returns nil if input is empty" do
      input = ""
      @parser.parse(input).should == nil
    end

    it "returns nil if input is a character" do
      input = "a"
      @parser.parse(input).should == nil
    end
    
    it "returns nil for a mix of letters and characters" do
      input = "1 2 a 3"
      @parser.parse(input).should == nil
    end
    
    it "returns nil for only white space" do
      input = "         "
      @parser.parse(input).should == nil
    end
  end
  
end
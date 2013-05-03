require 'mastermind/spec_helper'

describe Mastermind::CodeParser do
  
  before(:each) do
    @parser = Mastermind::CodeParser.new
  end

  it "parses correct code input" do
    input = "0 1 2 3 4"
    @parser.parse(input).should == [0, 1, 2, 3, 4]
  end
  
  it "returns nil if input is empty" do
    input = ""
    @parser.parse(input).should == nil    
  end
  
  it "returns nil if input is a character" do
    input = "a"
    @parser.parse(input).should == nil
  end
  
  it "parses input with extra space in the front and at the end" do
    input = "   0 1 2 3   "
    @parser.parse(input).should == [0, 1, 2, 3]
  end
  
end
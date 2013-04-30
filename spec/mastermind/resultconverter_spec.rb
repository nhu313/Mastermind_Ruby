require 'mastermind/spec_helper'

describe Mastermind::ResultConverter do
  before(:each) do
    @converter = Mastermind::ResultConverter.new
  end
  
  it "converts 1 exact match results" do
    @converter.to_string([1, 0, 0]).should == "[b]"
  end

  it "converts all exact match results for 1+" do
    @converter.to_string([3, 0, 0]).should == "[b b b]"
  end
  
  it "converts all correct value but incorrect position" do
    @converter.to_string([0, 5, 0]).should == "[w w w w w]"
  end
  
  it "converts all incorrect value" do
    @converter.to_string([0, 0, 2]).should == "[]"
  end
  
  it "converts mix results" do
    @converter.to_string([2, 1, 3]).should == "[b b w]"
  end
  
end
require 'mastermind/codegenerator'

describe Mastermind::CodeGenerator do
  
  it "generates code with the correct size" do
    code = Mastermind::CodeGenerator.new.getRandomCode(5)
    code.size.should == 5
  end
  
end
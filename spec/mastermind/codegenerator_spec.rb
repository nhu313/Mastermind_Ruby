require 'mastermind/codegenerator'

describe Mastermind::CodeGenerator do
  
  it "generates code with the correct size" do
    code_size = 7
    random_number = 3
    
    @generator = Mastermind::CodeGenerator.new
    @generator.stub(:random_number).times.and_return(random_number)
    
    code = @generator.random_code(code_size)

    code.should == [random_number]*code_size
  end
  
end
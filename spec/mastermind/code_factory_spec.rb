require 'mastermind/code_factory'

describe Mastermind::CodeFactory do
  
  it "create code with the correct size" do
    code_size = 3
    random_number = 8
    
    factory = Mastermind::CodeFactory.new
    factory.stub(:random_number).times.and_return(random_number)
    
    code = factory.random_code(code_size)

    code.value.should == [random_number]*code_size
  end
end
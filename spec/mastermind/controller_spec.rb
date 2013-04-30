require 'mastermind/controller'

describe Mastermind::Controller do
  
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @controller = Mastermind::Controller.new(@input, @output)
  end

  it "prints welcome message and result explaination" do
    welcome_message = "Welcome!"
    result_explaination = "rules"
    content = mock(Mastermind::Content)
    content.should_receive(:welcome_message).and_return(welcome_message)
    content.should_receive(:result_explaination).and_return(result_explaination)
    @controller.content = content
    @controller.start_game
    
    @output.string.should == welcome_message + result_explaination
  end  
end
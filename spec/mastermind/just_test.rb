class Hello
  
  def talk
    self.say
  end
  
  def say
    "something"
  end
  
end

describe Hello do

  
  
  it "returns hello" do
#    Hello.stub!(:say).and_return("hello world")
    @hello = Hello.new
    @hello.stub(:say).and_return("hello world")
#    Hello.should_receive(:say).and_return("hello world")
    answer = @hello.talk
    answer.should == "hello world"
  end
end
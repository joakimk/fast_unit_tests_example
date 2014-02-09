require 'example'

describe Example, "hello" do
  it "should return a formatted greeting" do
    Example.new.greet('joe').should == "Hello, Joe"
  end

  it "should handle an empty string" do
    Example.new.greet(' ').should == "Hello, what's your name?"
  end
end

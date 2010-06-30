require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
#  -----------------------------------------------------------------------------

describe Matrix, "When I create a matrix, it" do
  before(:each) do
    @matrix = Matrix.new 5,5
  end

  it "should assign and read values via [x,x]" do
    @matrix[1,1] = 2
    @matrix[1,1].should == 2
  end

  it "should xxx" do
    pp @matrix.to_s
  end
end
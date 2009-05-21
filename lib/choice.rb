
class Choice 
  attr_reader :rep 
  
  def initialize(*rep, &action) 
    @rep, @action = rep, action 
  end 
  
  def call(*args, &proc) 
    @action.call(*args, &proc) 
  end 
end 

DONE = Choice.new("Done")

# p DONE.to_yaml
# p ["Done", DONE].include?(DONE)
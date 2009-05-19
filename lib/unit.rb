class Unit
  attr_reader :name, :health, :movement, :actions
  attr_accessor :x, :y

  def initialize(player, name) 
    @player = player 
    @name = name 
    @health = 10 
    @movement = 2 
    @actions = [] 
  end
end 

class Human < Unit; end 
class Soldier < Human; end 
class Doctor < Human; end 
class Dinosaur < Unit; end 
class VRaptor < Dinosaur; end 
class TRex < Dinosaur; end 

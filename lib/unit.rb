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
  
  def hurt(damage)
    return if dead?
    @health -= damage
    die if dead?
  end
  
  def dead?
    @health <= 0    
  end
  
  def alive?
    ! dead?
  end
  
  def die
    @player.game.message_all "#{name} died."
  end
  
  def enemy?(other)
    (other != nil) && (player != other.player)
  end
  
  def friend?(other)
    (other != nil) && (player == other.player)
  end
  
  def done?
    @done
  end 
  
  def done
    @done = true
  end 
  
  def new_turn
    @done = false
  end
  
  def move(x, y)
    @player.game.map.move(@x, @y, x, y)
    @x = x
    @y = y
  end

  def rep
    [self.class.shortname, name]
  end
  
  def move_choices
    map = @player.game.map 
    all = map.all_positions 
    near = all.find_all {|x, y| map.within?(@movement, @x, @y, x, y) } 
    valid = near.find_all {|x, y| map.units[x, y].nil? } 
    return valid.collect do |x, y| 
      Choice.new("Move", x, y) { self.move(x, y) } 
    end 
  end
  
  def action_choices 
    return actions.collect do |action| 
      Choice.new(*action.rep) { action } 
    end 
  end 

end 

#  -----------------------------------------------------------------------------

class Human < Unit
  attr_reader :caliber, :range 

  def initialize(*args) 
    super(*args) 
    @actions << Shoot 
    @caliber = 4 
    @range = 3 
  end 
end 

#  -----------------------------------------------------------------------------

class Soldier < Human; end 

#  -----------------------------------------------------------------------------

class Doctor < Human
  attr_reader :heal 

  def initialize(*args) 
    super(*args) 
    @actions << FirstAid 
    @heal = 2 
  end   
end 

#  -----------------------------------------------------------------------------

class Dinosaur < Unit
  attr_reader :teeth 

  def initialize(*args) 
    super(*args) 
    @actions << Bite 
    @teeth = 2 
  end  
end 

#  -----------------------------------------------------------------------------

class VRaptor < Dinosaur; end 

#  -----------------------------------------------------------------------------

class TRex < Dinosaur
  def initialize(*args) 
    @teeth = 5 
  end 
end 

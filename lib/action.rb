class Action 
  attr_reader :unit, :game
  
  def initialize(unit, game, x, y) 
    @unit = unit 
    @game = game
    @x = x 
    @y = y 
  end 
  
  def call 
    raise NotImplementedError 
  end
  
  def target 
    game.map.units[@x, @y] 
  end 

  def self.rep 
    [self.class.shortname, @x, @y]
  end 
  
  def self.range(unit)
    1
  end 
  
  def self.target?(unit, other)
    unit.enemy?(other)
  end 
  
  # Default Action generator assumes action is something you 
  # do to the enemy standing next to you. This behavior will 
  # overriden in many subclasses. 
  def self.generate(unit, game) 
    map = game.map 
    near = map.near_positions(range(unit), unit.x, unit.y) 
    targets = near.find_all{|x, y| target?(unit, map.units[x, y]) } 
    return targets.collect{|x, y| self.new(unit, game, x, y) } 
  end 
end

class Attack < Action 
  def damage_caused(unit)
    raise NotImplementedError
  end 
  
  def past_tense
    raise NotImplementedError
  end 
  
  def call 
    amount = damage_caused() 
    game.message_all("#{unit.name} #{past_tense} #{target.name} for #{amount} damage.") 
    target.hurt(amount) 
  end 
end 

#  -----------------------------------------------------------------------------

class Bite < Attack 
  def damage_caused
    @unit.teeth
  end 

  def past_tense
    "bit"
  end 
end 

#  -----------------------------------------------------------------------------

class Shoot < Attack 
  def self.range(unit)
    unit.range
  end 

  def damage_caused
    @unit.caliber
  end 

  def past_tense
    "shot"
  end 
end 

#  -----------------------------------------------------------------------------

class FirstAid < Action 
  def self.target?(unit, other)
    unit.friend?(other)
  end 

  def call 
    target.hurt(-unit.heal) 
    game.message_all("#{unit.name} healed #{target.name} for #{unit.heal} health.") 
  end 
end

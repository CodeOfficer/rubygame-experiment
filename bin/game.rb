#!/usr/bin/env ruby

require "rubygems"
require "pp"

Dir.glob(File.join(File.dirname(__FILE__), '../lib/*.rb')).each {|f| require f }


# class FakeGame 
# attr_accessor :map 
# end 
# class FakePlayer 
# attr_accessor :game 
# end
# 
# player = FakePlayer.new 
# player.game = FakeGame.new 
# 
# 
# forest = Terrain.new("Forest")
# grass = Terrain.new("Grass")
# mountains = Terrain.new("Mountains")
# plains = Terrain.new("Plains")
# water = Terrain.new("Water")
# 
# terrain_key = {
#   "f" => forest,
#   "g" => grass,
#   "m" => mountains,
#   "p" => plains,
#   "w" => water,
# }
# 
# layout = <<-END
#   gggggggggg
#   gggggggwww
#   ggggggwwff
#   gggppppppp
#   ggppggwfpf
#   ggpgggwwff
# END
# 
# # map = Map.new terrain_key, layout
# # pp map.near_positions(2, 3, 3)
# 
# player.game.map = Map.new(terrain_key, layout)
# dixie = Human.new(player, "Dixie") 
# player.game.map.place(0, 0, dixie) 
# dixie.move(1, 0)
# # pp player.game.map.rep
# 
# x, y = 0, 1 
# choice = Choice.new("Move", x, y) { unit.move(x, y) } 
# pp choice.rep
# choice.call


forest = Terrain.new("Forest")
grass = Terrain.new("Grass")
mountains = Terrain.new("Mountains")
plains = Terrain.new("Plains")
water = Terrain.new("Water")

terrain_key = {
  "f" => forest,
  "g" => grass,
  "m" => mountains,
  "p" => plains,
  "w" => water,
}

map = Map.new terrain_key, <<-END
  gggggggggg
  gggggggwww
  ggggggwwff
  gggppppppp
  ggppggwfpf
  ggpgggwwff
END

game = DinoWars.new

human = CLIPlayer.new("Human")
computer = DumbComputer.new("Computer")

game.add_player(human)
game.add_player(computer)

nathan = Soldier.new(human, "Nathan")
vik = Soldier.new(human, "Vik")
winston = Doctor.new(human, "Winston")

human.add_unit(nathan)
human.add_unit(vik)
human.add_unit(winston)

game.add_map(map) do |map|
  map.place(3, 0, nathan)
  map.place(4, 0, vik)
  map.place(5, 0, winston)

  vr1 = VRaptor.new(computer, 'Velociraptor 1')
  vr2 = VRaptor.new(computer, 'Velociraptor 2')
  vr3 = VRaptor.new(computer, 'Velociraptor 3')

  computer.clear_units
  computer.add_unit(vr1)
  computer.add_unit(vr2)
  computer.add_unit(vr3)
  
  map.place(0, 5, vr1)
  map.place(1, 5, vr2)
  map.place(2, 5, vr3)
end

game.run

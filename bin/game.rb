#!/usr/bin/env ruby

require "rubygems"
require "pp"

Dir.glob(File.join(File.dirname(__FILE__), '../lib/*.rb')).each {|f| require f }


class FakeGame 
attr_accessor :map 
end 
class FakePlayer 
attr_accessor :game 
end

player = FakePlayer.new 
player.game = FakeGame.new 


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

layout = <<-END
  gggggggggg
  gggggggwww
  ggggggwwff
  gggppppppp
  ggppggwfpf
  ggpgggwwff
END

# map = Map.new terrain_key, layout
# pp map.near_positions(2, 3, 3)

player.game.map = Map.new(terrain_key, layout)
dixie = Unit.new(player, "Dixie") 
player.game.map.place(0, 0, dixie) 
dixie.move(1, 0)
pp player.game.map.rep
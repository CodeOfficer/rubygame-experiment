#!/usr/bin/env ruby

require "rubygems"
require "pp"

Dir.glob(File.join(File.dirname(__FILE__), '../lib/*.rb')).each {|f| require f }

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

map = Map.new terrain_key, layout

pp map.near_positions(2, 3, 3)

require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'matrix' 
require 'map' 
require 'terrain' 
#  -----------------------------------------------------------------------------

describe Map, "When I create a map, it" do
  before(:each) do
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
    @map = Map.new terrain_key, <<-END
      gggggggggg
      gggggggwww
      ggggggwwff
      gggppppppp
      ggppggwfpf
      ggpgggwwff
    END
  end

  it "should calculate as +" do
    @map.width.should == 2
  end
end
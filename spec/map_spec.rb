require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
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
    terrain_layout = <<-END
      gggggggggg
      gggggggwww
      ggggggwwff
      gggppppppp
      ggppggwfpf
      ggpgggwwff
    END
    @map = Map.new terrain_key, terrain_layout
  end

  it "should calculate as +" do
    @map.width.should == 10
  end
end

class LocationOccupiedError < Exception; end


# accepts key as a hash
# accepts layout as a map in string format
# gggggggggg
# gggggggwww
# ggggggwwff
# gggppppppp
# ggppggwfpf
# ggpgggwwff
class Map
  attr_reader :terrain, :units
  
  def initialize(key, layout)
    rows = layout.split("\n")
    rows.collect! { |row| row.gsub(/\s+/, '').split(//) }
    y = rows.size
    x = rows[0].size
    @terrain = Matrix.new(x, y)
    @units = Matrix.new(x, y)
    rows.each_with_index do |row, y|
      row.each_with_index do |glyph, x|
        @terrain[x, y] = key[glyph]
      end
    end
  end
  
  def place(x, y, unit)
    @units[x, y] = unit
    unit.x = x
    unit.y = y
  end
  
  def move(old_x, old_y, new_x, new_y)
    raise LocationOccupiedError.new(new_x, new_y) if @units[new_x, new_y]
    @units[new_x, new_y] = @units[old_x, old_y]
    @units[old_x, old_y] = nil
  end
  
  def all_positions
    @terrain.all_positions    
  end

  def within?(distance, x1, y1, x2, y2)
    (x1 - x2).abs + (y1 - y2).abs <= distance
  end

  def near_positions(distance, x, y)
    all_positions.find_all{ |x2, y2| within?(distance, x, y, x2, y2) }
  end
  
  def rep
    [@terrain.rep, @units.rep]
  end
end




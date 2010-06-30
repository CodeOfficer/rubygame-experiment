
class LocationOccupiedError < Exception; end

class Map
  attr_reader :terrain, :units
  attr_reader :width, :height
  
  def initialize(key, layout)
    rows = layout.split("\n")
    rows.collect! { |row| row.gsub(/\s+/, '').split(//) }
    @height = rows.size
    @width = rows[0].size
    @terrain = Matrix.new(@width, @height)
    @units = Matrix.new(@width, @height)
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
  
  def to_s
    @terrain.to_s
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




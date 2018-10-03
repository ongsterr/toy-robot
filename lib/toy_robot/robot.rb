module ToyRobot
  class Robot
    DIRECTION = ["NORTH", "EAST", "SOUTH", "WEST"]
    attr_reader :x, :y, :facing

    def initialize(x = 0, y = 0, facing = "NORTH")
      @x = x
      @y = y
      @facing = facing
    end

    def move_north
      @y += 1
    end
    
    def move_east
      @x += 1
    end

    def move_south
      @y -= 1
    end

    def move_west
      @x -= 1
    end

    def move
      send("move_#{@facing.downcase}")
    end

    def turn_left
      turn(:left)
    end

    def turn_right
      turn(:right)
    end

    def report
      {

      }
    end

    private

    def turn(turn_direction)
      index = DIRECTION.index(@facing)
      rotation = turn_direction == :right ? 1 : -1
      @facing = DIRECTION.rotate(rotation)[index]
    end
    
  end
end
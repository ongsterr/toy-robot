module ToyRobot
  class Robot
    DIRECTION = ["NORTH", "EAST", "SOUTH", "WEST"]
    BOARD_SETUP = {
      x: 4,
      y: 4
    }
    attr_reader :x, :y, :facing

    def initialize(x = 0, y = 0, facing = "NORTH")
      if validate_position(x, y, facing)
        @x = x
        @y = y
        @facing = facing
      else
        raise ArgumentError, "Please ensure that x <= #{BOARD_SETUP[:x]}, y <= #{BOARD_SETUP[:y]} and facing is one of #{DIRECTION.join(" ")}"
      end
    end

    def place(x, y, facing)
      if validate_position(x, y, facing)
        @x = x
        @y = y
        @facing = facing
      else
        raise ArgumentError, "Please ensure that x <= #{BOARD_SETUP[:x]}, y <= #{BOARD_SETUP[:y]} and facing is one of #{DIRECTION.join(" ")}"
      end
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
        x: @x,
        y: @y,
        facing: @facing
      }
    end

    private

    def validate_position(x, y, facing)
      (x >= 0 && x <= BOARD_SETUP[:x]) && (y >= 0 && y <= BOARD_SETUP[:y]) && (DIRECTION.include? facing)
    end

    def turn(turn_direction)
      index = DIRECTION.index(@facing)
      rotation = turn_direction == :right ? 1 : -1
      @facing = DIRECTION.rotate(rotation)[index]
    end
    
  end
end
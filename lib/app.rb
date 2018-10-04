require "tty"
require_relative "./toy_robot/robot"

module App
  NUMBER_OF_COLUMN = ToyRobot::BOARD_SETUP[:x] + 1
  NUMBER_OF_ROW = ToyRobot::BOARD_SETUP[:y] + 1
  DIRECTIONS = ToyRobot::DIRECTION

  class Board
    attr_accessor :board

    def initialize(x = 0, y = 0)
      rows = (0...NUMBER_OF_ROW).to_a.reverse!.map! do |row|
        if row == y
          arr = Array.new(NUMBER_OF_COLUMN, " ")
          arr[x] = "🤖"
          arr
        else
          Array.new(NUMBER_OF_COLUMN, " ")
        end
      end

      @board = TTY::Table.new rows: rows
    end

    def render(space)
      @board.render(:ascii) do |renderer|
        renderer.alignments = [:center]
        renderer.padding = [1,3,1,3]
        renderer.border do
          top_left    "#{space}+"
          mid_left    "#{space}+"
          left        "#{space}|"
          bottom_left "#{space}+"
        end
        renderer.border.separator = :each_row
      end
    end
  end

  class Prompt
    def initialize
      @prompt = TTY::Prompt.new
    end

    def main_selection
      selection_array = [
        { value: "PLACE", name: "Position Mr Robot" },
        { value: "MOVE", name: "Move Mr Robot a step forward" },
        { value: "TURN LEFT", name: "Turn Mr Robot left" },
        { value: "TURN RIGHT", name: "Turn Mr Robot right" },
        { value: "REPORT", name: "Report Mr Robot's position" },
        { value: "EXIT", name: "Say Goodbye to Mr Robot" },
      ]
      @prompt.select("What do you want to do with Mr Robot?", selection_array)
    end

    def place_robot
      position_x = @prompt.select("Please specify position x of the robot.", (0...NUMBER_OF_COLUMN).to_a.map { |x| x.to_s })
      position_y = @prompt.select("Please specify position y of the robot.", (0...NUMBER_OF_ROW).to_a.map { |x| x.to_s })
      direction = @prompt.select("Please specify the direction Mr Robot will be facing.", DIRECTIONS)
      return {
        x: position_x.to_i,
        y: position_y.to_i,
        facing: direction
      }
    end

    def error(msg)
      @prompt.error(msg)
    end

    def ok(msg)
      @prompt.ok(msg)
    end
  end
end
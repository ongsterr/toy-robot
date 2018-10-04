require_relative "./lib/app"
require_relative "./lib/toy_robot/robot"
require "tty"

# Specify some const
app_width = TTY::Screen.width
divider = "-" * app_width
spacing = " " * (app_width / 2.75)
welcome_msg = "Welcome to the Move-a-Bot app!"
main_selection = ""

@robot = ToyRobot::Robot.new
@robot_position = {
  x: 0,
  y: 0,
  facing: "NORTH"
}

# App interface initiation
until main_selection == "EXIT" do
  board = App::Board.new(@robot_position[:x], @robot_position[:y])
  board_display = board.render(spacing)
  prompt = App::Prompt.new
  
  # App main view
  system("clear")
  puts divider
  puts welcome_msg.center(app_width)
  puts divider
  puts spacing
  puts board_display
  prompt.ok("Mr Robot is currently facing #{@robot_position[:facing]}...")
  puts spacing

  # App main selection panel
  main_prompt = App::Prompt.new
  main_selection = main_prompt.main_selection
  
  # App sub selection panel
  case main_selection
  when "PLACE"
    puts "Where do you want to place the robot?"
    @robot_position = prompt.place_robot
    @robot.place(@robot_position[:x], @robot_position[:y], @robot_position[:facing])
  when "MOVE"
    begin
      @robot.move
      @robot_position = @robot.report
    rescue ArgumentError => error
      puts spacing
      prompt.error(error.message)
      sleep 3
    end
  when "TURN LEFT"
    @robot.turn_left
    @robot_position = @robot.report
  when "TURN RIGHT"
    @robot.turn_right
    @robot_position = @robot.report
  when "REPORT"
    position = @robot.report
    puts spacing
    puts "Mr Robot is currently at position x: #{position[:x]}, y: #{position[:y]} and facing #{position[:facing]}!"
    sleep 3
  end
end



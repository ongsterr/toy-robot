require "spec_helper"

describe ToyRobot::Robot do
  context "Testing robot initialization" do
    it "should initialize robot based on specified parameters" do
      robot = ToyRobot::Robot.new(2, 3, "SOUTH")
      expect(robot.report).to eq({x: 2, y: 3, facing: "SOUTH"})
    end

    it "should raise argument error if not initialized properly" do
      expect { ToyRobot::Robot.new(-1, 2, "BAD") }.to raise_error(ArgumentError)
    end
  end

  context "Testing robot placement" do
    subject { ToyRobot::Robot.new }

    it "should place robot based on specified parameters" do
      subject.place(1, 1, "EAST")
      expect(subject.report).to eq({x: 1, y: 1, facing: "EAST"})
    end

    it "should raise argument error if not place properly" do
      expect { subject.place(-1, 2, "BAD") }.to raise_error(ArgumentError)
    end
  end
  
  context "Testing robot functionality at default position" do
    subject { ToyRobot::Robot.new }

    it "should move 2 spaces north" do
      2.times { subject.move_north }
      expect(subject.y).to eq(2)
    end
  
    it "should move 2 spaces east" do
      2.times { subject.move_east }
      expect(subject.x).to eq(2)
    end
  
    it "should raise error if asked to move south" do
      expect { subject.move_south }.to raise_error(ArgumentError)
    end
  
    it "should raise error if asked to move west" do
      expect { subject.move_west }.to raise_error(ArgumentError)
    end
  
    it "should move 2 spaces in its current direction" do
      2.times { subject.move }
      expect(subject.y).to eq(2)
    end

    it "should rotate to 90 degree when turning right" do
      subject.turn_right
      expect(subject.facing).to eq("EAST")
    end

    it "should rotate to -90 degree when turning left" do
      subject.turn_left
      expect(subject.facing).to eq("WEST")
    end

    it "should report current x, y position and facing" do
      expect(subject.report).to eq({x: 0, y: 0, facing: "NORTH"})
    end
  end

  context "Testing a series of actions with the robot" do
    subject { ToyRobot::Robot.new }

    it "should reach the destination of x: 0, y: 1, facing: NORTH" do
      subject.place(0,0,"NORTH")
      subject.move
      expect(subject.report).to eq({x: 0, y: 1, facing: "NORTH"})
    end

    it "should reach the destination of x: 0, y: 0, facing: WEST" do
      subject.place(0, 0, "NORTH")
      subject.turn_left
      expect(subject.report).to eq({x: 0, y: 0, facing: "WEST"})
    end

    it "should reach the destination of x: 3, y: 3, facing: NORTH" do
      subject.place(1, 2, "EAST")
      2.times { subject.move }
      subject.turn_left
      subject.move
      expect(subject.report).to eq({x: 3, y: 3, facing: "NORTH"})
    end
  end
end
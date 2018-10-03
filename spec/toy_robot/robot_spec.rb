require "spec_helper"

describe ToyRobot::Robot do
  subject { ToyRobot::Robot.new(0) }

  context "Testing robot movement functionality at default position" do
    it "should move 2 spaces north" do
      2.times { subject.move_north }
      expect(subject.y).to eq(2)
    end
  
    it "should move 2 spaces east" do
      2.times { subject.move_east }
      expect(subject.x).to eq(2)
    end
  
    it "should move 2 spaces south" do
      2.times { subject.move_south }
      expect(subject.y).to eq(-2)
    end
  
    it "should move 2 spaces west" do
      2.times { subject.move_west }
      expect(subject.x).to eq(-2)
    end
  
    it "should move 4 spaces in its current direction" do
      4.times { subject.move }
      expect(subject.y).to eq(4)
    end
  end

  context "Testing robot rotation functionality at default position" do
    it "should rotate to 90 degree when turning right" do
      subject.turn_right
      expect(subject.facing).to eq("EAST")
    end

    it "should rotate to -90 degree when turning left" do
      subject.turn_left
      expect(subject.facing).to eq("WEST")
    end
  end
end
require_relative 'spec_helper'

describe "Room" do
    let(:room1) { Hotel::Room.new(1) }
    let(:room2) { Hotel::Room.new(20) }
    let(:room3) { Hotel::Room.new(2) }

  describe "initialize" do
    it "each room has a number that can be read" do
      room1.number.must_equal 1
      room2.number.must_equal 20
    end
  end
end

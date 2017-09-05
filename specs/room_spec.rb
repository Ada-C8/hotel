require_relative 'spec_helper'

describe "room" do
  describe "initialize" do
    it "should be an instance of a room" do
      input = Hotel::Room.new
      input.must_be_instance_of Hotel::Room
    end
  end
end

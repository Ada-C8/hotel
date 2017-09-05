require_relative "spec_helper"

describe "Room class" do

  describe "initialize" do
    it "Creates an instance" do
      new_room = Hotel::Room.new
      new_room.must_be_kind_of Hotel::Room
    end
  end

end

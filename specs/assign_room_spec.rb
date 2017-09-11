require_relative "spec_helper"

describe "AssignRoom class" do
  describe "initialize" do
    it "creates an instance of a reserved room" do
      @date_range = "12-3-2017", "12-5-2017"
      @room_number = 1
      Hotel::AssignRoom.new(@date_range, @room_number).must_be_kind_of Hotel::AssignRoom
    end

  end
end

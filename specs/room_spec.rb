require_relative 'spec_helper'

describe "Administration#Room wave 1" do

  describe "instantiate room" do
    it "have a room number" do
      room_num = 4
      room = Administration::Room.new(room_num)

      room.room_num.must_equal 4
      room.room_num.must_be_kind_of Integer
    end

    it "raises an ArgumentError if the room number is not an Integer" do
      proc {
        Administration::Room.new("four")
      }.must_raise ArgumentError
    end
  end
end #hotel room wave 1

require_relative 'spec_helper'

describe "Hotel#Room wave 1" do
  describe "instantiate room" do

    it "create a new room with a room number" do
    room = Hotel::Room.new(4)
    room.room_num.must_equal 4
  end

  end


end #hotel room wave 1

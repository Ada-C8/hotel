require_relative 'spec_helper'

describe "Hotel#Room wave 1" do
  describe "instantiate room" do

    it "create a new room with a room number" do
      room_num = 4
      status = :open
      dates_reserved = "look at dates"

      room = Hotel::Room.new(room_num, status, dates_reserved)

      room.must_respond_to :room_num
      room.room_num.must_equal 4
      room.room_num.must_be_kind_of Integer

  end

  end


end #hotel room wave 1

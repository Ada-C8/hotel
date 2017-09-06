require_relative 'spec_helper'

describe "Hotel#Room wave 1" do

  before "room instance" do
    room_num = 4
    status = :open
    date_reserved = Date.new(2018, 01, 01)

    @room = Hotel::Room.new(room_num, status, date_reserved)

  end

  describe "instantiate room" do

    it "create a new instance of room" do
      @room.must_respond_to :room_num
      @room.room_num.must_equal 4
      @room.room_num.must_be_kind_of Integer

      @room.must_respond_to :status
      @room.status.must_equal :open
      @room.status.must_be_kind_of Symbol

      @room.must_respond_to :date_reserved
      @room.date_reserved.must_equal Date.new
    end
  end

  describe "hotel#room" do
    it "stores all rooms in an Array" do
      Hotel::Room.all.must_be_kind_of Array
    end

    it "accepts a vaild room number" do
      @room.room_numbers(4).must_equal true
    end

    it "raises an ArgumentError if the room number is not 1-20" do
      proc{
        @room.room_numbers(25)
      }.must_raise ArgumentError
    end

  end


end #hotel room wave 1

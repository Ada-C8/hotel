require_relative 'spec_helper'

describe 'Room' do
  before do
    @my_room = Hotel_System::Room.new(1)
  end
  describe '#reserve' do
    before do
      @check_in = Date.new(2017,9,5)
      @check_out = Date.new(2017,9,7)
    end
    it "raises an Argument Error if parameters are not Date objects" do
      proc {@my_room.reserve("today", "tomorrow")}.must_raise ArgumentError
    end
    it "raises an Argument Error if check_out is earlier than or same day as check_in" do
      proc {@my_room.reserve(@check_in, @check_in)}.must_raise ArgumentError
      proc {@my_room.reserve(@check_out, @check_in)}.must_raise ArgumentError
    end
    it "creates a new reservation" do
      @my_room.reserve(@check_in, @check_out).must_be_instance_of Hotel_System::Reservation
    end
    it "adds the reservation to the room's list of reservations" do
      @my_room.reserve(@check_in, @check_out).must_be_instance_of Hotel_System::Reservation
      @my_room.reservations.must_be_instance_of Array
      @my_room.reservations.length.must_equal 1
    end
  end
end

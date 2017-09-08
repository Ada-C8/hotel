require_relative 'spec_helper'

describe "Reservation" do
  before do
    @admin = Hotel::Admin.new()
    check_in = Date.new(2017, 1, 15)
    check_out = Date.new(2017, 1, 17)
    room = @admin.find_room(6)
    @reservation = Hotel::Reservation.new(check_in, check_out, room)
  end

  describe "initialize" do

    it "Can create an object of class Reservation" do
        @reservation.must_be_instance_of Hotel::Reservation
        @reservation.room.must_be_instance_of Hotel::Room
    end

  end

end

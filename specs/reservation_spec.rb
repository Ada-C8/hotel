require_relative 'spec_helper'

describe "Reservation" do
  describe "initialize" do
    before do
      @ada_inn = Hotel::Building.new
      @date = '2017-02-12'
      @ada_inn.rooms[0].reserve(@date, 9)
    end

    it "Creates a Reservation with a check-in date, a room, a number of nights and a check_out" do

      @ada_inn.rooms[0].reservation.must_be_instance_of Hotel::Reservation

      @ada_inn.rooms[0].reservation.check_in.must_be_kind_of Date
      @ada_inn.rooms[0].reservation.check_in.must_equal Date.parse('2017-02-12')

      @ada_inn.rooms[0].reservation.room.must_be_instance_of Hotel::Room
      @ada_inn.rooms[0].reservation.room.number.must_equal 1

      @ada_inn.rooms[0].reservation.nights.must_be_kind_of Integer
      @ada_inn.rooms[0].reservation.nights.must_equal 9

      @ada_inn.rooms[0].reservation.check_out.must_equal Date.parse('2017-02-21')


    end

  end

end

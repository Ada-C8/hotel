require_relative 'spec_helper'

describe "HotelBooking::Reservation class" do
  describe "initialize" do
    it "requires five arguments, an id, a guest, a check-in date, a check-out date, and a room" do
      proc {HotelBooking::Reservation.new}.must_raise ArgumentError
      proc {HotelBooking::Reservation.new("Jim Bob", Date.parse("2018-07-01"),5)}.must_raise ArgumentError

      new_res = HotelBooking::Reservation.new(Date.parse("July 1"), Date.parse("2018-07-03"), 5, 14)

      new_res.must_be_instance_of HotelBooking::Reservation
    end

    it "creates a Reservation instance that allows us to read the id, guest, check-in date, check-out date, type, and room " do
      read_res = HotelBooking::Reservation.new(Date.parse("2018-07-01"), Date.parse("2018-07-03"), 5,100)

      read_res.must_be_instance_of HotelBooking::Reservation
      [read_res.check_in, read_res.check_out].each do |date|
        date.month.must_equal 7
      end

      read_res.check_in.day.must_equal 1
      read_res.check_out.day.must_equal 3
      read_res.id.must_equal 100
      read_res.room_id.must_equal 5
      read_res.type.must_equal :standard
    end

  end #end initialize tests

  describe "Cost" do
    it "Returns an integer value that is the total cost of the reservation" do
      reservation = HotelBooking::Reservation.new(Date.parse("2018-02-14"), Date.parse("2018-02-16"),5,1)

      reservation.cost.must_equal 400

      res2 = HotelBooking::Reservation.new(Date.parse("2018-12-01"), Date.parse("2018-12-02"), 17,3)

      res2.cost.must_equal 200
    end

  end
end

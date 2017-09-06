require_relative 'spec_helper'

describe "Hotel::Reservation class" do
  describe "initialize" do
    it "requires five arguments, an id, a guest, a check-in date, a check-out date, and a room" do
      proc {Hotel::Reservation.new}.must_raise ArgumentError
      proc {Hotel::Reservation.new("Jim Bob", "2018-07-01",5)}.must_raise ArgumentError

      new_res = Hotel::Reservation.new("Jim Bob", "July 1", "2018-07-03", 5)

      new_res.must_be_instance_of Hotel::Reservation
    end

    it "creates a Reservation instance that allows us to read the id, guest, check-in date, check-out date, and room " do
      read_res = Hotel::Reservation.new("Dale Cooper", "2018-07-01", "2018-07-03", 5)

      read_res.must_be_instance_of Hotel::Reservation
      [read_res.check_in, read_res.check_out].each do |date|
        date.month.must_equal 7
      end

      read_res.check_in.day.must_equal 1
      read_res.check_out.day.must_equal 3

      read_res.room.id.must_equal 5
      read_res.guest.must_equal "Dale Cooper"
    end

  end #end initialize tests

  describe "self.all" do
    it "initializes with zero reservations" do
      new_hotel_reservations = Hotel::Reservation.all

      new_hotel_reservations.must_be_instance_of Array
      new_hotel_reservations.count.must_equal 0
    end


  end #end self.all


  describe "Cost" do
    it "Returns an integer value that is the total cost of the reservation" do
      reservation = Hotel::Reservation.new(1,"2018-02-14", "2018-02-16",5)

      reservation.cost.must_equal 400

      res2 = Hotel::Reservation.new(3, "2018-12-01", "2018-12-02", 17)

      res2.cost.must_equal 200
    end

  end
end

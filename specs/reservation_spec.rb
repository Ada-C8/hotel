require_relative 'spec_helper'

describe "My_Hotel::Reservation" do
  before do
    @feb1 = Date.civil(2017,2,1)
    @feb2 = Date.civil(2017,2,1)
    @feb6 = Date.civil(2017,2,6)
    @holiday = My_Hotel::Reservation.new(@feb1, @feb6)
    @rooms_avail = {1 =>200,
      2 => 200,
      3 => 200
    }
  end

  describe "initialize" do
    it "can be created" do
      @holiday.must_be_kind_of My_Hotel::Reservation
      @holiday.nights_booked.must_be_kind_of My_Hotel::Date_Range
    end
  end

  describe "assign_room number" do
    it "assign a room if there is one available" do
      @holiday.room_number.must_be_nil
      @holiday.assign_room(@rooms_avail)
      @holiday.room_number.must_be_kind_of Integer
      (1..3).must_include @holiday.room_number
    end

    it "does not assign a room if there is not one available" do
      rooms_avail ={}
      proc{@holiday.assign_room(rooms_avail).must_raise ArgumentError}
    end

  end
  describe "set_cost" do
    it "calculates the cost of a reservation" do
      @holiday.assign_room(@rooms_avail)
      @holiday.set_cost.must_equal 1200 #nominal
      one_night =  My_Hotel::Reservation.new(@feb1, @feb1)
      one_night.assign_room(@rooms_avail)
      one_night.set_cost.must_equal 200

    end
  end

  describe "set_reservation_id" do
    it "creates a reservation id" do
      new_reservation = My_Hotel::Reservation.new(@feb1, @feb6)
      new_reservation.set_reservation_id
      new_reservation.reservation_id.must_be_kind_of String
    end
  end
end

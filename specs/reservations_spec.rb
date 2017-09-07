require_relative 'spec_helper'
describe "Reservations class" do
  before do
    room3 = [Hotel::Room.new(3)]
    @res1 = Hotel::Booking.new(1, [Hotel::Room.new(1),Hotel::Room.new(2)], Hotel::DateRange.new(Date.new(2017,9,5),Date.new(2017,9,6)))
    @res2 = Hotel::Booking.new(2,room3, Hotel::DateRange.new(Date.new(2017,9,5),Date.new(2017,9,6)))
    @res3 = Hotel::Booking.new(3, [Hotel::Room.new(4)], Hotel::DateRange.new(Date.new(2017,9,5),Date.new(2017,9,8)))
    @res4 = Hotel::Booking.new(4, room3, Hotel::DateRange.new(Date.new(2017,9,6),Date.new(2017,9,7)))
    res_arr = [@res1,@res2,@res3,@res4]
    @hotel = Hotel::Reservations.new
    res_arr.each do |res|
      @hotel.all_reservations << res
    end
  end
  describe "initializes" do
    it "initializes" do
      @hotel.must_be_kind_of Hotel::Reservations
    end
    it "must respond to all_rooms and all_reservations" do
      @hotel.must_respond_to :all_rooms && :all_reservations
    end
    it "all_rooms must give a list of all of the rooms in the hotel" do
      @hotel.all_rooms.length.must_equal 20
    end
    it "all_reservations must be a kind of array" do
      @hotel.all_reservations.must_be_kind_of Array
    end
  end
  describe "check_reservations" do
    it "will raise an error if invalid date range" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,6)
      proc{@hotel.check_reservations(check_out,check_in)}.must_raise InvalidDateRangeError
    end
    it "must be an array of room objects" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,6)
      @hotel.check_reservations(check_in,check_out)[0].must_be_kind_of Hotel::Room
      @hotel.check_reservations(check_in,check_out).must_be_kind_of Array
    end
    it "return a list of rooms booked for a given date range, rooms should be unique" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,8)
      arr_booked = @hotel.check_reservations(check_in,check_out)
      arr_booked.length.must_equal 4
      arr_booked_unique = arr_booked.uniq
      arr_booked.length.must_equal arr_booked_unique.length
    end
    it "returns an empty array if nothing is booked" do
      check_in = Date.new(2017,10,5)
      check_out = Date.new(2017,10,6)
      @hotel.check_reservations(check_in,check_out).must_be_empty
    end
  end
  describe "check_availability" do
    it "returns an array of room objects" do
    end
    it "returns a list of rooms available, rooms should be unique" do
    end
  end
end

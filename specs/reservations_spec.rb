require_relative 'spec_helper'
describe "Reservations class" do
  before do
    @check_in = Date.new(2017,9,5)
    @check_out = Date.new(2017,9,6)
    @hotel = Hotel::Reservations.new
    @hotel.make_reservation(@check_in,@check_out,1)
    @hotel.make_reservation(@check_in,@check_out,1)
    @hotel.make_reservation(@check_in,@check_out + 2,1)
    @hotel.make_reservation(@check_in + 1,@check_out + 1,4)
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
      proc{@hotel.check_reservations(@check_out,@check_in)}.must_raise InvalidDateRangeError
    end
    it "must be an array of room objects" do
      holder = @hotel.check_reservations(@check_in,@check_out)
      holder[0].must_be_kind_of Hotel::Room
      holder.must_be_kind_of Array
    end
    it "return a list of rooms booked for a given date range, rooms should be unique" do
      arr_booked = @hotel.check_reservations(@check_in,@check_out + 3)
      arr_booked_unique = arr_booked.uniq
      arr_booked.length.must_equal 5
      arr_booked.length.must_equal arr_booked_unique.length
    end
    it "returns an empty array if nothing is booked" do
      @hotel.check_reservations(@check_in + 5,@check_out + 6).must_be_empty
    end
  end
  describe "check_availability" do
    it "returns an array of room objects" do
      @hotel.check_availability(@check_in,@check_out).must_be_kind_of Array
      @hotel.check_availability(@check_in,@check_out)[0].must_be_kind_of Hotel::Room
    end
    it "returns a list of rooms available, rooms should be unique" do
      rooms_available = @hotel.check_availability(@check_in,@check_out)
      rooms_available_unique = rooms_available.uniq
      rooms_available.length.must_equal rooms_available_unique.length
    end
    it "returns an empty array if everything is booked" do
      @hotel.make_reservation(@check_in - 1,@check_out - 1,20)
      # binding.pry
      #will fail until we do make booking method
      @hotel.check_availability(@check_in - 1,@check_out - 1).must_be_empty
    end
  end
  describe "make_reservation" do
    it "it will make create object of booking class" do
      reservation = @hotel.make_reservation(@check_in,@check_out,1)
      reservation.must_be_kind_of Hotel::Booking
    end
    it "will raise an ArgumentError if no rooms are avabilable" do
      proc{@hotel.make_reservation(@check_in,@check_out,21)}.must_raise InvalidRoomQuantity
    end
    it "it adds a new reservation to all_reservations" do
      before = @hotel.all_reservations.length
      @hotel.make_reservation(@check_in,@check_out,1)
      after = @hotel.all_reservations.length
      after.must_equal (before + 1)
    end
    it "make sure it creates consecutive ID numbers" do
      id1 = @hotel.make_reservation(@check_in,@check_out,1).id
      id2 = @hotel.make_reservation(@check_in,@check_out,1).id
      binding.pry
      id2.must_equal (id1 + 1)
    end
    xit "picks the next consecutive room number available" do
      #not sure how to to test this
    end
    xit "you can book a room on the check out date" do
      # not sure about this...
    end
    it "raise ArgumentError if you request more than 20 rooms" do
      proc{@hotel.make_reservation(@check_in-3,@check_out-3,21)}.must_raise InvalidRoomQuantity
    end
  end
end

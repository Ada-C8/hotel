require_relative 'spec_helper'
require_relative '../lib/hotel'


describe "DateRange" do

  describe "initialize" do

    before do
      @start_date = Date.new(2018,1,1)
      @end_date = Date.new(2018,1,3)
      @date = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "checks initialize" do

	  @date.must_respond_to :start_date
    @date.start_date.must_be_kind_of Date #edge1
	  @date.start_date.must_equal @start_date #edge2

	  @date.must_respond_to :end_date
	  @date.end_date.must_be_kind_of Date #edge1
	  @date.end_date.must_equal @end_date #edge2
    end

	it "checks initialize when start date is after end date" do
	  start_date = Date.new(2018,1,1)
	  end_date = Date.new(2018,1,3)
	  proc {DateRange.new(end_date, start_date)}.must_raise Exception
	end
  end
end #end of date range






describe "Reservation" do
  describe "initialize" do

    before do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,4)
      date = Hotel::DateRange.new(start_date, end_date)
      @res = Hotel::Reservation.new(1, date, 200)
    end

    it "checks initialize" do

	  @res.must_respond_to :room_number
	  @res.room_number.must_be_kind_of Integer
	  @res.room_number.must_equal 1

	  @res.must_respond_to :cost
	  @res.cost.must_be_kind_of Integer
	  @res.cost.must_equal 600
    end

  end #end of initialize do

  describe "initialize but checks for same day problems" do

  before do
    start_date = Date.new(2018,1,1)
    end_date = Date.new(2018,1,1)
    date = Hotel::DateRange.new(start_date, end_date)
    @res = Hotel::Reservation.new(1, date, 200)
  end

  it "checks for same day checkin/checkout" do
    @res.cost.must_equal 200
  end

end #end of initialize same day

end #end of reservation






describe "Room" do
  describe "initialize" do
    before do
      @room = Hotel::Room.new(1)
    end

    it "can initialize rooms" do
      @room.must_be_instance_of Hotel::Room
      @room.must_respond_to :room_number
      @room.room_number.must_be_kind_of Integer
      @room.room_number.must_equal 1
    end
  end
end #end of room class









describe "Hotel" do
  describe "initialize" do
    before do
      @hotel = Hotel::ReservationSystem.new()
    end

    it "checks initialize" do

      @hotel.must_respond_to :rooms
      @hotel.rooms.must_be_kind_of Array
      @hotel.rooms.length.must_equal 20

      @hotel.must_respond_to :room_reservation
      keys = @hotel.room_reservation.keys
      keys.length.must_equal 20

    end
  end



end

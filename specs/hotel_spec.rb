require_relative 'spec_helper'
require_relative '../lib/hotel'


describe "DateRange" do

  describe "initialize" do

    before do
      @start_date = Date.new(2017,1,1)
      @end_date = Date.new(2017,1,3)
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
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  proc {DateRange.new(end_date, start_date)}.must_raise Exception
	end
  end
end

# describe "Rooms" do
#   before do
#     @rooms = Hotel::Hotel_Rooms.new(1)
#   end
#
#   it "can initialize rooms" do
#     @rooms.must_be_instance_of Hotel::Hotel_Rooms
#     @rooms.number.must_be_kind_of Integer
#     #@rooms.room_id.must_equal 1
#   end

  # describe "Room" do
  #   describe "initialize" do
  #     it "checks initialize" do
  #       room = Hotel::Hotel_Rooms.new(1)
  #       room.must_respond_to :room_number
  # 	  room.room_number.must_be_kind_of Integer
  # 	  room.room_number.must_equal 1
  #     end
  #   end
  # end

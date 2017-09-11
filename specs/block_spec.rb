require_relative 'spec_helper'
require_relative '../lib/hotel'

describe "Blocks" do
  describe "initialize" do
    it "checks initialize" do
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  rooms = [1,2]
	  date = DateRange.new(start_date, end_date)
      block = Hotels::Block_Of_Rooms.new(rooms, date, 1)
      
	  block.must_respond_to :available_rooms
	  block.available_rooms.must_equal rooms
	  block.available_rooms.must_be_kind_of Array
	  
	  block.must_respond_to :date
	  block.date.must_equal date
	  block.date.must_be_kind_of DateRange
	  
	  block.must_respond_to :room_booked
	  block.room_booked.must_equal [false, false]
	  
	  block.must_respond_to :id
	  block.id.must_equal 1  
    end 
  end
end

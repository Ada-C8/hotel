require_relative 'spec_helper'
require_relative '../lib/hotel'

describe "Hotel" do
  describe "initialize" do
    it "checks initialize" do
      hotel = Hotels::Hotel.new()
	  
	  hotel.must_respond_to :rooms
	  hotel.rooms.must_be_kind_of Array
	  hotel.rooms.length.must_equal 20
	  
	  hotel.must_respond_to :reservations_by_room
	  keys = hotel.reservations_by_room.keys
	  keys.length.must_equal 20
	  
      hotel.must_respond_to :reservation_by_date
	  hotel.reservation_by_date.must_equal {}
    end 
  end
  
  describe "reserve_room" do
    it "checks reserve_room" do
      hotel = Hotels::Hotel.new()
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date = DateRange.new(start_date, end_date)
	  
	  hotel.reserve_room(1, date)
	  
	  hotel.reservations_by_room[1].wont_be_nil
    end 
	
	it "checks reserve_room on existing room" do
      hotel = Hotels::Hotel.new()
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date = DateRange.new(start_date, end_date)
	  
	  hotel.reserve_room(1, date)
	  proc {hotel.reserve_room(1, date)}.must_raise Exception
    end 
	
	it "checks reserve_room when start date overlaps" do
      hotel = Hotels::Hotel.new()
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date1 = DateRange.new(start_date, end_date)
	  
	  start_date = Date.new(2017,1,2)
	  end_date = Date.new(2017,1,3)
	  date2 = DateRange.new(start_date, end_date)
	  
	  hotel.reserve_room(1, date1)
	  proc {hotel.reserve_room(1, date2)}.must_raise Exception
    end 
	
	it "checks reserve_room when start dates are the same" do
      hotel = Hotels::Hotel.new()
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date1 = DateRange.new(start_date, end_date)
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date2 = DateRange.new(start_date, end_date)
	  
	  hotel.reserve_room(1, date1)
	  proc {hotel.reserve_room(1, date2)}.must_raise Exception
    end 
	
	it "checks reserve_room when end date overlaps with start date" do
      hotel = Hotels::Hotel.new()
	  
	  start_date = Date.new(2017,1,5)
	  end_date = Date.new(2017,1,7)
	  date1 = DateRange.new(start_date, end_date)
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,6)
	  date2 = DateRange.new(start_date, end_date)
	  
	  hotel.reserve_room(1, date1)
	  proc {hotel.reserve_room(1, date2)}.must_raise Exception
    end 
	
	it "checks reserve_room when start date is the end date of existing reservation" do
      hotel = Hotels::Hotel.new()
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date1 = DateRange.new(start_date, end_date)
	  
	  start_date = Date.new(2017,1,3)
	  end_date = Date.new(2017,1,5)
	  date2 = DateRange.new(start_date, end_date)
	  
	  hotel.reserve_room(1, date1)
	  hotel.reserve_room(1, date2)
	  hotel.reservations_by_room[1].length.must_equal 2
    end 
	
	it "checks reserve_room when room is in a block" do
      hotel = Hotels::Hotel.new()
	  
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date1 = DateRange.new(start_date, end_date)
	  
	  hotel.make_new_block(5, date1, 1)
	  room = hotel.room_blocks[0].available_rooms[0]
	  proc {hotel.reserve_room(room, date1)}.must_raise Exception
    end 
  end
  
  describe "get_all_rooms" do
	it "get_all_rooms returns an array" do
		hotel = Hotels::Hotel.new()
		rooms = hotel.get_all_rooms()
		
		rooms.length.must_equal 20
		rooms.must_be_kind_of Array
	end
  end
end

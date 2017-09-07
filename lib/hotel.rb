require_relative 'room'
require_relative 'reservation'
require 'date'

class Hotel
  attr_reader :rooms, :reservation_by_room, :reservation_by_date

  def initialize
    @rooms = []
	@reservations_by_room = {}
	@reservations_by_date = {}
	20.times do |i|
		@rooms << Room.new(i)
		@reservations[i] = []
	end
	
  end
  
  def reserveRoom(room_number, startDate, endDate)
	current_reservations = @reservations_by_room[room_number]
	
	current_reservations.each do |i|
		if startDate < i.startDate  
			#end date happens after the start of an existing reservation
			if (endDate - i.startDate).to_i > 0 
				raise ArgumentError, "This room is booked during the dates requested"
			end
			#if the start dates are the same, or the start date is less than the end date
		elsif startDate == i.startDate || (startDate - i.endDate).to_i < 0 
			raise ArgumentError, "This room is booked during the dates requested"
		end
	end
	new_reservation = Reservation.new(room_number, startDate, endDate)
	@reservations_by_room[room_number] << new_reservation
	
	if @reservations_by_date.key?(startDate)
		@reservations_by_date[startDate] << new_reservation
	else
		@reservations_by_date[startDate] = [new_reservation]
	end
		
  end
  
  def getAllRooms
	return @rooms
  end
  
  def getOpenRooms(startDate, endDate)
	available_rooms = []
	@rooms.length.times do |i|
		available_rooms[i] = true
	end
	
	current_date = startDate
	while current_date < endDate do
		if @reservations_by_date.key?(current_date)
			current_reservations = @reservations_by_date[current_date]
			current_reservations.each do  |this_room|
				available_rooms[this_room.room_number] = false
			end
		end
		current_date += 1
	end
	
	for 
	return available_roooms
  end
  
  
end

date1 = Date.new(2007,1,1)
date2 = Date.new(2008,5,2)
print (date2 - date1).to_i
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
  
  def reserve_room(room_number, date)
	current_reservations = @reservations_by_room[room_number]
	
	current_reservations.each do |i|
		if date.start_date < i.start_date  
			#end date happens after the start of an existing reservation
			if (date.end_date - i.start_date).to_i > 0 
				raise ArgumentError, "This room is booked during the dates requested"
			end
			#if the start dates are the same, or the start date is less than the end date
		elsif date.start_date == i.start_date || (date.start_date - i.end_date).to_i < 0 
			raise ArgumentError, "This room is booked during the dates requested"
		end
	end
	new_reservation = Reservation.new(room_number, date)
	@reservations_by_room[room_number] << new_reservation
	
	if @reservations_by_date.key?(date.start_date)
		@reservations_by_date[date.start_date] << new_reservation
	else
		@reservations_by_date[date.start_date] = [new_reservation]
	end
		
  end
  
  
end

date1 = Date.new(2007,1,1)
date2 = Date.new(2008,5,2)
print (date2 - date1).to_i
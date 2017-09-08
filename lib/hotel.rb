require_relative 'room'
require_relative 'reservation'
require_relative 'daterange'
require_relative 'block_of_rooms'
require 'date'

class Hotel
  attr_reader :rooms, :reservation_by_room, :reservation_by_date

  def initialize
    @rooms = []
	@reservations_by_room = {}
	@reservations_by_date = {}
	@room_blocks = []
	@rooms_currently_in_block = []
	20.times do |i|
		@rooms << Room.new(i)
		@reservations[i] = []
	end
  end
  
  def reserve_room(room_number, date)
	
	if @rooms_currently_in_block.includes?(room_number)
		@room_blocks.each do |current_block|
			current_block.rooms.each do |current_room_in_block|
				if current_room_in_block == room_number
					if date.start_date > current_block.start_date && 
					date.start_date < current_block.end_date
						raise ArgumentException, "This room is part of a block"
					end
				end
			end
		end
	end
	
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
  
  def get_all_rooms
	return @rooms
  end
  
  def get_open_rooms(date)
	available_rooms = []
	20.times do |i|
		available_rooms[i] = true
	end
	
	current_date = date.start_date
	while current_date < date.end_date do
		if @reservations_by_date.key?(current_date)
			current_reservations = @reservations_by_date[current_date]
			current_reservations.each do  |this_room|
				available_rooms[this_room.room_number] = false
			end
		end
		current_date += 1
	end
	
	atleast_one_open_room = 0
	available_rooms.each do |i|
		if i == true
			atleast_one_open_room += 1
		end
	end
	
	if atleast_one_open_room == 0
		raise ArgumentError, "There are no open rooms for the dates in question"
	end	
	
	return available_roooms
  end
  
  def make_new_block(number_of_rooms, date, id)
	available_rooms = get_open_rooms(date)
	if number_of_rooms > 5
		raise ArgumentException, "Room blocks must be 5 rooms or less"
	elsif number_of_rooms > available_rooms 
		raise ArgumentException, "There are only #{available_rooms.length} available for the dates selected"
	else
		rooms = []
		number_of_rooms.times do |i|
			rooms << available_rooms[i]
			@rooms_currently_in_block << available_rooms[i]
		end
		new_block = Block_Of_Rooms.new(rooms, date, id)
		@room_blocks << new_block
	end
  end
  
  def check_block_for_availablity
    @room_blocks.each do |block_of_rooms|
		block_of_rooms.room_booked.each do |is_room_booked|
			if is_room_booked == true
				return true
			end
		end
	end
	return false
  end
  
  def reserve_room_from_block(block_id)
	if @room_blocks == []
		raise ArgumentError, "There are no current room blocks"
	else
		@room_blocks.each do |current_block|
			if current_block.id == block_id
				if current_block.available_rooms.include?(false)
					index = 0
					current_block.room_booked.each do |find_open_room|
						if find_open_room[index] == false
							room_number = current_block.available_rooms[index].room_number
							new_reservation = Reservation.new(room_number, current_block.date, 175)
							find_open_room[index] = true
						end
					end
				else
					puts "There are no rooms avaiable for this block"
				end
			end
		end
	end
  end
  
  
  
end

date = DateRange.new(Date.new(2007,1,1), Date.new(2008,5,2))


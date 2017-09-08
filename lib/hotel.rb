require_relative 'room'
require_relative 'reservation'
require_relative 'daterange'
require_relative 'block'
require 'date'

module Hotels 
	class Hotel
	  attr_reader :rooms, :reservation_by_room, :reservation_by_date

	  def initialize
		@rooms = []
		@reservations_by_room = {}
		@reservations_by_date = {}
		@room_blocks = []
		@rooms_currently_in_block = []
		20.times do |i|
			@rooms << Hotels::Room.new(i)
			@reservations_by_room[i] = []
		end
	  end
	  
	  def reserve_room(room_number, date)
		#checks to see if the room in question is a part of a block 
		##and if the dates conflict
		if @rooms_currently_in_block.include?(room_number)
			@room_blocks.each do |current_block|
				current_block.rooms.each do |current_room_in_block|
					if current_room_in_block.room_number == room_number
						if date.start_date > current_block.start_date && 
						date.start_date < current_block.end_date
							raise ArgumentException, "This room is part of a block. Change your start date"
						elsif date.end_date > current_block.start_date
							raise ArgumentException, "This room is part of a block. Change your end date"
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
		
		
		new_reservation = Hotels::Reservation.new(room_number, date)
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
		open_rooms = []
		20.times do |i|
			open_rooms[i] = true
		end
		
		current_date = date.start_date
		while current_date < date.end_date do
			if @reservations_by_date.key?(current_date)
				current_reservations = @reservations_by_date[current_date]
				current_reservations.each do  |this_reservation|
					open_rooms[this_reservation.room_number] = false
				end
			end
			current_date += 1
		end
		
		available_rooms = []
		index = 0
		open_rooms.each do |value|
			if value == true
				available_rooms << @rooms[index]
			end
			index += 1
		end
		
		return available_rooms
	  end
	  
	  def make_new_block(number_of_rooms, date, id)
		available_rooms = get_open_rooms(date)
		if number_of_rooms > 5
			raise ArgumentException, "Room blocks must be 5 rooms or less"
		elsif number_of_rooms > available_rooms.length
			raise ArgumentException, "There are only #{available_rooms.length} available for the dates selected"
		else
			rooms = []
			number_of_rooms.times do |i|
				rooms << available_rooms[i]
				@rooms_currently_in_block << available_rooms[i]
			end
			new_block = Hotels::Block_Of_Rooms.new(rooms, date, id)
			@room_blocks << new_block
		end
	  end
	  
	  def check_block_for_availablity(block_id)
		@room_blocks.each do |block|
			if block.id == block_id
				block.room_booked.each do |is_room_booked|
					if is_room_booked == false
						return true
					end
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
					if check_block_for_availablity(block_id)
						room = get_open_room_from_block(current_block)
						new_reservation = Hotels::Reservation.new(room, current_block.date, 175)
					else
						puts "There are no rooms avaiable for this block"
					end
				end
			end
		end
	  end
	  
	  def get_open_room_from_block(block)
		rooms = block.room_booked
		rooms.each_with_index do |value, index|
			if value == false
				block.room_booked[index] = true
				return block.available_rooms[index]
			end
		end
	  end
	  
	  private :get_open_room_from_block
	end
end

hotel = Hotels::Hotel.new()
date = DateRange.new(Date.new(2007,1,1), Date.new(2007,5,2))
puts (hotel.get_open_rooms(date)).length
hotel.reserve_room(1, date)
puts (hotel.get_open_rooms(date)).length
hotel.make_new_block(2, date, 1)
puts "###"
hotel.reserve_room_from_block(1)
puts "###"
hotel.reserve_room_from_block(1)
puts "###"
hotel.reserve_room_from_block(1)
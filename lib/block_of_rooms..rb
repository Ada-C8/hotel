require_relative 'room'

class Block_Of_Rooms << Room
	attr_reader :rooms, :date, :room_booked, :id
	
	def initialize(rooms, date, id)
		@available_rooms = rooms
		@room_booked = []
		@id = id
		@available_rooms.length.times do |i|
			@room_booked << false
		end
		@date = date
		@cost = 175
	end
end
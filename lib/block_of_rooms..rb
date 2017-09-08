class Block_Of_Rooms << Room
	attr_reader :rooms, :date
	
	def initialize(rooms, date)
		@available_rooms = rooms
		@room_booked = []
		@available_rooms.length.times do |i|
			@room_booked << false
		end
		@date = date
		@cost = 175
	end
end
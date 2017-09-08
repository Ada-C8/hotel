class Block_Of_Rooms << Room
	attr_reader :rooms, :date
	
	def initialize(rooms, date)
		@available_rooms = rooms
		@date = date
		@cost = 175
	end
end
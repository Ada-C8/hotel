class Reservation
	attr_reader :room, :start_date, :end_date, :cost

	def initialize(room, start_date, end_date)
		@room = room
		@start_date = start_date
		@end_date = end_date
		@cost = 0
		if start_date == end_date
			@cost = 200
		else
			@cost = 200 * (@end_date - start_date).to_i
		end
	end
end 

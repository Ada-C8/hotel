class Reservation
	attr_reader :room, :start_date, :end_date, :cost

	def initialize(room, date)
		@room = room
		@start_date = date.start_date
		@end_date = date.end_date
		if date.start_date == date.end_date
			@cost = 200
		else
			@cost = 200 * (@end_date - @start_date).to_i
		end
	end
end 

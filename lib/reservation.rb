class Reservation
	attr_reader :room, :start_date, :end_date, :cost

	def initialize(room, date, cost=nil)
		@room = room
		@start_date = date.start_date
		@end_date = date.end_date
		cost = 0
		
		if cost == nil
			cost = 200
		else
			cost = 175
		end
		
		if date.start_date == date.end_date
			@cost = cost
		else
			@cost = cost * (@end_date - @start_date).to_i
		end
	end
end 

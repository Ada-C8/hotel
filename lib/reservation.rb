require 'date'

class Reservation
	attr_reader :room, :startDate, :endDate, :cost

	def initialize(room, startDate, endDate)
		@room = room
		@startDate = startDate
		@endDate = endDate
		@cost = 0
		if startDate == endDate
			@cost = 200
		else
			@cost = 200 * (@endDate - startDate).to_i
		end
	end
end 

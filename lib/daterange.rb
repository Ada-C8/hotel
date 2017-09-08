require 'date'

class DateRange
	attr_reader :start_date, :end_date

	def initialize(start_date, end_date)
		if start_date < end_date
			raise ArugmentException, "The start date must come before the end_date"
		else
			@start_date = start_date
			@end_date = end_date
		end
	end
end

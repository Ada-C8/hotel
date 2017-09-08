#custom_exceptions.rb

class WrongDateFormatError < ArgumentError
  def initialize
    super ("You've entered the date in the wrong format. Please use MM/DD/YY")
  end
end

class ReservationNotAvailableError < ArgumentError
  def initialize
    super ("A reservation is not available for the date range you have entered.")
  end
end

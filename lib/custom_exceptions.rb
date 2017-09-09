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

class NoPartyByThatNameError < ArgumentError
  def initialize
    super ("There is no block of rooms reserved under that name. Please make sure you have the exact party name.")
  end
end

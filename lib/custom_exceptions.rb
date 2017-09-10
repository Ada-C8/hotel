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

class AllBlockRoomsAssignedError < ArgumentError
  def initialize
    super ("All the reservations made for that block of room have been assigned. You may check to see if there is a room available at the standard rate.")
  end
end

class ExceededRoomLimitForBlocksError < ArgumentError
  def initialize
    super ("There is a 5-room maximum limit for block reservations.")
  end
end

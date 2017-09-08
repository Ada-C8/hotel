class NoRoomError < StandardError
  # Raised when there are not enough available rooms for request
end

class DatesError < StandardError
  # Raised when dates are in wrong order, out of range, etc
  # NOT raised for invalid date input (use ArgumentError)
end

class NoBlockError < StandardError
  # Raised when provided block does not exist/cannot be found
end

class DiscountError < StandardError
  # Raised when discount is not number from 0-100
end

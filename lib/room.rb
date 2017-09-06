# The Room class will just need to create an instance of a room that has a cost and a room number
# The rooms for the hotel will be created in the Booking class.

module Hotel
  class Room
    attr_reader :room_number, :cost
    def initialize(room_number)
      @room_number = room_number.to_i
      @cost = 200.0
    end # initialie
  end # class Room
end # module Hotel

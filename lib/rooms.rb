module Hotel
  class Room
    attr_reader :number

    def initialize(number)
      @number = check_room_number(number)
    end

    private

    # Raises ArgumentError if room number supplied is already taken by a room or if number supplied is not an Integer. Otherwise, sets the room number.
    def check_room_number(number)
      if number.is_a?(Integer) == false
        raise ArgumentError.new "room number must be an integer"
      else
        @number = number
      end
    end

  end # end of Rooms class
end # end of Hotel module

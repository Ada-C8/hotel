=begin
- Room class makes ojects of room.
- Its attributes are:
- room number


- Each room should have a room number.
  - pass in the room number to the room object.
  - to automate making all 20 rooms we need a times loop from 1-20.
  - set an iterative variable to 1.
  - errors for room numbers not on the sequence 1-20
  - errors for reservation status not being either



=end


module Hotel
  class Room

    attr_reader :room_num, :reservation_status

    def initialize(room_num, reservation_status)
      @room_num = room_num
      @reservation_status = reservation_status
    end
  end
end

require_relative 'date_range'
module Hotel
  class BookingSystem
      attr_reader :rooms, :reservations_rooms_hash

#Access list of all rooms in the hotel.
      def initialize
        @rooms = Hotel::Room.all # {ID : RoomObject}
        @collection_of_reservation = {} # key: reservation, value: hash
      end

  end
end

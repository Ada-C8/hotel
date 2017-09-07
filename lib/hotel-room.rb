require_relative 'hotel-errors'
module Hotel
  class Room
    #room has a number (1-20)
    NUMBER_OF_ROOMS = 20

    attr_reader :number

    def initialize(num)
      if num > NUMBER_OF_ROOMS || num <= 0
        raise InvalidRoomError.new "Room number not valid"
      else
        @number = num
      end
    end

    def self.list_all
      hotel_rooms = [] #NOTE should this be an class variable?
      NUMBER_OF_ROOMS.times do |i|
        hotel_rooms << self.new(i+1)
      end
      return hotel_rooms
    end

    def available?(start_date, end_date)
      rooms_available = self.class.all_available_rooms(start_date, end_date)
      rooms_available.each do |room|
        if room.number == @number
          return true
        end
      end
      return false
    end

    def self.all_available_rooms(start_date, end_date)
      unavailable_rooms = []
      if end_date < start_date
        raise DateError.new "End date is before start date"
      end
      (start_date...end_date).each do |date|
        list = Hotel::Reservation.list_for_date(date)
        list += Hotel::Reservation.blocklist_for_date(date)
        unavailable_rooms << list.map {|reservation| reservation.room.number}
      end
      unavailable_rooms.flatten!.uniq!
      available_room_numbers = (1..NUMBER_OF_ROOMS).to_a - unavailable_rooms
      available_rooms = []
      available_room_numbers.each do |i|
        available_rooms << self.new(i)
      end
      return available_rooms
    end

  end
end

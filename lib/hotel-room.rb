module Hotel
  class Room
    #list of rooms - self method?
    #room has a number (1-20)
    NUMBER_OF_ROOMS = 20

    attr_reader :number

    def initialize(num)
      if num > NUMBER_OF_ROOMS || num <= 0
        raise ArgumentError.new "Room number not valid"
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

    # def self.list_all
    #   #NOTE: may be repeat of self.all, do I need to recreate everytime I want to show a list?
    #   return @@hotel_rooms
    # end

    def available?(start_date, end_date)
      rooms_available = self.class.all_available_rooms(start_date, end_date)
      rooms_available.each do |room|
        if room.number == self.number
          return true
        end
      end
      return false
    end

    def self.all_available_rooms(start_date, end_date)
      available_rooms = list_all
      (start_date...end_date).each do |date|
        list = Hotel::Reservation.list_for_date(date)
        list.each do |reservation|
          available_rooms.delete_at(reservation.room.number-1)
        end
      end
      return available_rooms
    end

  end
end

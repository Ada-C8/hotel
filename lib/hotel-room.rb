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
      # ap rooms_available
      rooms_available.each do |room|
        # ap "#{room.number} and #{@number}"
        if room.number == @number
          return true
        end
      end
      # puts "this is returning false"
      return false
    end

    def self.all_available_rooms(start_date, end_date)
      unavailable_rooms = []
      (start_date...end_date).each do |date|
        list = Hotel::Reservation.list_for_date(date)
        list += Hotel::Reservation.blocklist_for_date(date)
        unavailable_rooms << list.map {|reservation| reservation.room.number}
      end
      unavailable_rooms.flatten!.uniq!
      available_room_numbers = (1..NUMBER_OF_ROOMS).to_a - unavailable_rooms
      # ap available_room_numbers
      available_rooms = []
      available_room_numbers.each do |i|
        available_rooms << self.new(i)
      end
      return available_rooms
    end

  end
end

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

    def self.all
      @@hotel_rooms = [] #NOTE should this be an class variable?
      NUMBER_OF_ROOMS.times do |i|
        @@hotel_rooms << self.new(i+1)
      end
      return @@hotel_rooms
    end

    def self.list_all
      #NOTE: may be repeat of self.all, do I need to recreate everytime I want to show a list?
      return @@hotel_rooms
    end

  end
end

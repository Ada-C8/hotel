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
      array_of_rooms = []
      NUMBER_OF_ROOMS.times do |i|
        array_of_rooms << self.new(i+1)
      end
      return array_of_rooms
    end

  end
end

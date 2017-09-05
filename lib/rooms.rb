module Hotel
  class Rooms

    attr_reader :number

    def initialize(number)
      @number = number
    end

    def self.all
      rooms = []
      number = 0
      20.times do
        number += 1
        rooms << self.new(number)
      end
      return rooms
    end

    def self.find(number)
      all_rooms = Hotel::Rooms.all
      all_rooms.each do |room|
        if room.number == number
          return Rooms.new(room.number)
        end
      end
      raise ArgumentError.new("Room does not exist.")
    end


  end
end

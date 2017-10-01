module Hotels
  class Rooms

    attr_reader :number, :price

    def initialize(number, price: 200)
      @number = number
      @price = price
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
      all_rooms = Hotels::Rooms.all
      all_rooms.each do |room|
        if room.number == number
          return room
        end
      end
      raise ArgumentError.new("Room does not exist.")
    end


  end
end

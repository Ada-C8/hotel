#Hotel.rb
require 'awesome_print'

module Hotel_Chain
  class MyHotel

    attr_reader :no_of_rooms, :array_of_rooms

    def initialize(no_of_rooms = 20)
      @array_of_rooms = []
    end

    #Returns a list of all rooms in the hotel
    def self.all(no_of_rooms = 20)
      myhotel = Hotel_Chain::MyHotel.new
      no_of_rooms.times do |room|
         myhotel.array_of_rooms << Room.new(room+1)
      end
      puts "HOTEL ROOMS:"
      ap myhotel.array_of_rooms
      return myhotel.array_of_rooms
    end

    def self.print_list_of_rooms
      myhotel = Hotel_Chain::MyHotel.all
      i = 0
      myhotel.array_of_rooms.each do |room_id, rate|
        puts "#{i}. Room #{room_id} - $#{rate}"
      end
    end

  end
end

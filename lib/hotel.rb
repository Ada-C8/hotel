#Hotel.rb
require 'awesome_print'

module Hotel_Chain
  class MyHotel

    attr_reader :array_of_rooms

    def initialize(no_of_rooms = 20)
      @array_of_rooms = Array.new(no_of_rooms)
      no_of_rooms.times do |room|
        @array_of_rooms[room] = Room.new(room+1)
      end
    end

    #Returns a list of all rooms in the hotel
    # def self.all
    #   myhotel = Hotel_Chain::MyHotel.new
    #   myhotel.array_of_rooms.length.times do |room|
    #      myhotel.array_of_rooms[room] = Room.new(room+1)
    #   end
    #   return myhotel.array_of_rooms
    # end

    #Method is called to print a list for the administrator
    #myhotel = Hotel_Chain::MyHotel.new
    #myhotel.list_of_rooms
    def list_rooms
      #myhotel = Hotel_Chain::MyHotel.all
      list_array = []
      i = 0
      @array_of_rooms.each do |object|
          list_array << "#{i+1}. Room #{object.room_id} - $#{object.rate}/night"
          i += 1
      end
      return list_array
    end

  end
end

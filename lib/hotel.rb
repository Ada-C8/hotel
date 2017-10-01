require 'date'
require 'rooms'

module Hotels
  class Hotel
     attr_reader :rooms, :reservations
    def initialize
      @rooms = make_rooms
      @reservations = []
      @block_instance = []
    end


    def make_rooms
      rooms = Hotels::Rooms.all
      return rooms
    end

    


    def list_booked_rooms(date_range)
      booked_rooms = []
      date_range.each do |date|
       @reservations.each do |one_res|
         if one_res.date_range.include? date
            booked_rooms << one_res.room
         end
       end
      end
      return booked_rooms
    end

    def list_unbooked_rooms(list_booked_rooms)
      unbooked_rooms = []
    @rooms.each do |room|
      if list_booked_rooms.include? room
      else
        unbooked_rooms << room
      end
    end
    return unbooked_rooms
    end



    def find_room(list_unbooked_rooms)
      if list_unbooked_rooms.length == 0
        raise ArgumentError.new("Hotel is booked.")
      else
      room = list_unbooked_rooms.sample
      return room
      end
    end

    def make_reservation(find_room, date_range)
      @reservations << Hotels::Reservations.new(find_room, date_range)
      return @reservations
    end

    def make_blocks(date_range, number_of_rooms)
      booked_rooms = self.list_booked_rooms(date_range)
      unbooked_rooms= self.list_unbooked_rooms(booked_rooms)
      block_of_rooms = []
      if unbooked_rooms.length >= number_of_rooms && number_of_rooms <= 5
         number_of_rooms.times do
         found_room = self.find_room(unbooked_rooms)
         block_of_rooms << found_room
         self.make_reservation(found_room, date_range)
         end

      else
        raise ArgumentError.new("Not enough rooms available.")
      end
        return block_of_rooms
    end

    def make_block_instance(date_range, block_of_rooms)
      @block_instance << Hotels::Block.new(date_range, block_of_rooms)
    end


  end
end

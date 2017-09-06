#Hotel.rb
require 'awesome_print'
require 'date'

module Hotel_Chain
  class MyHotel

    attr_reader :array_of_rooms, :reservations_array

    def initialize(no_of_rooms = 20)
      @array_of_rooms = Array.new(no_of_rooms)
      no_of_rooms.times do |room|
        @array_of_rooms[room] = Room.new(room+1)
      @reservations_array = []
      end
    end

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

    # admin would enter the following to create a new reservation:
    # reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
    def store_reservation(check_in_date, check_out_date)
      @reservations_array << Hotel_Chain::Reservation.new(check_in_date, check_out_date)
    end




  end
end

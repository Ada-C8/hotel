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
    #hotel = Hotel_Chain::MyHotel.new
    #hotel.list_of_rooms
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
    # hotel.store_reservation(check_in_date, check_out_date)
    def store_reservation(check_in_date, check_out_date)
      @reservations_array << Hotel_Chain::Reservation.new(check_in_date, check_out_date)
    end

    def make_reservations_by_date_array(date)
      reservations_on_date = []
      @reservations_array.each do |reservation|
        if (reservation.check_in_date...reservation.check_out_date).cover?(Date.strptime(date, "%m/%d/%Y"))
          reservations_on_date << reservation
        end
      end
      # if reservations_on_date.length == 0
      #   return "There are currently no reservations for #{date}"
      # end
      return reservations_on_date
    end


    #calculate length of stay
    #iterate through reservation to see if it
    def rooms_available(check_in_date, check_out_date)
      rooms_available_array = []

      check_in= Date.strptime(check_in_date, "%m/%d/%Y")
      check_out = Date.strptime(check_out_date, "%m/%d/%Y")
      length_of_stay = (check_out - check_in).to_i

      @array_of_rooms.each do |room|
        room_check = []
        @reservations_array.each do |reservation|
          length_of_stay.times do |day|
            if room.room_id == reservation.room_id
              if (reservation.check_in_date...reservation.check_out_date).cover?((check_in)+day)
                room_check << reservation.room_id
              end
            end
          end
          if room_check.length == length_of_stay
            rooms_available_array << room_check[0]
          end
        end
      end
      puts "rooms_available_array: #{rooms_available_array}"
      return rooms_available_array
    end





    # def print_reservations_by_date(date)
    #   array = []
    #   reservations_on_date = self.make_reservations_by_date_array(date)
    #   reservations_on_date.each do |reservation|
    #     array  << "Room #{reservation.room_id} is reserved from #{reservation.check_in_date} to #{reservation.check_out_date}"
    #   end
    #   puts array
    # end







  end
end

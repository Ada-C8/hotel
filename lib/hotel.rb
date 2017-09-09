require 'pry'
require_relative 'reservation'

module Hotel

  class Hotel

    attr_reader :list_of_rooms, :price, :reservation_collection, :reservation_made, :date_list

    def initialize(num_of_rooms, price)
      @list_of_rooms = []
      room_num = 0
      num_of_rooms.times do |room|
        room_num += 1
        @list_of_rooms << room_num
      end #loop

      @price = price
      @reservation_collection = []
    end #initialize

    def make_reservation(check_in, check_out, room_num)
      @reservation_made = Reservation.new(check_in, check_out, room_num)
      # binding.pry

      @reservation_collection << @reservation_made
    end

    def date_list_of_reservations(date)
      @date_list = []
      date = Date.parse(date)
      @reservation_collection.each do |entry|
        # binding.pry
        if entry.date_range.check_in <= date && entry.date_range.check_out >= date
          @date_list << [entry.room_num, entry.date_range.check_in.to_s, entry.date_range.check_out.to_s]
        end
      end
      return @date_list
    end #def

    # def list_of_rooms
    #   @list_of_rooms.each do |room|
    #     puts "Room #{room}"
    #   end
    # end #list_of_rooms
    # not needed for this more abstract hotel class


  end #class

end #module

# my_hotel = Hotel::Hotel.new(20, 200)
# my_hotel.make_reservation('sept 8 2017', 'sept 10 2017', 4)
# puts my_hotel.make_reservation('sept 8 2017', 'sept 10 2017', 4)
# puts my_hotel.reservation.room_num.must_equal 4

@bb_hotel = Hotel::Hotel.new(20, 200)
@bb_hotel.make_reservation('sept 8 2017', 'sept 10 2017', 4)
@bb_hotel.make_reservation('sept 7 2017', 'sept 11 2017', 3)
p @bb_hotel.date_list_of_reservations('sept 9 2017')

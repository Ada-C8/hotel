require 'pry'
require_relative 'reservation'

module Hotel

  class Hotel

    attr_reader :list_of_rooms, :price, :reservation_collection, :reservation_made

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

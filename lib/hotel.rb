require_relative 'reservation'

module Hotel

  class Hotel

    attr_reader :list_of_rooms, :price, :reservation_collection

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

    def make_reservation
      @reservation = Hotel::Reservation.new(check_in, check_out, room_num)
      @reservation_collection << @reservation
    end

    # def list_of_rooms
    #   @list_of_rooms.each do |room|
    #     puts "Room #{room}"
    #   end
    # end #list_of_rooms
    # not needed for this more abstract hotel class


  end #class

end #module

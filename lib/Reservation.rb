require 'pry'
require 'date'
module Hotel

  class Reservation
    attr_reader :guest, :check_in, :check_out, :room
    attr_accessor :all_reservations, :id

    @@all_reservations = []

    def initialize(guest, check_in,check_out,room_id)
      @id = 1
      @guest =  guest #Optional- create guest object
      @check_in = Date.parse(check_in) #ruby Date object
      @check_out = Date.parse(check_out) #ruby Date object
      @room= Hotel::Room.find_by_id(room_id) # later, this will be a room object assigned via namespacing method Hotel::Room.find_by(room_id)
      @totalcost = 200
    end #end initialize


    def self.all #returns array
      all_reservations = []

      return all_reservations

    end

    def cost
      @totalcost = (check_out.mjd - check_in.mjd)* @room.nightly_rate
      return @totalcost
    end

    # def self.find_by_guest(guest_id)
    # end
    #

    #
    # def self.find_by_room(room_id)
    # end

    #def self.find_by_id(reservation_id)
    #end

  end

end

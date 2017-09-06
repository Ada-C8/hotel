require 'pry'

module Hotel

  class Reservation
    attr_reader :id, :guest, :check_in, :check_out, :room

    def initialize(id, guest, check_in,check_out,room_id)
      @id = id
      @guest =  guest #Optional- create guest object
      @check_in = check_in #ruby Date object
      @check_out = check_out #ruby Date object
      @room= room_id # later, this will be a room object assigned via namespacing method Hotel::Room.find_by(room_id)
    end #end initialize

    # def self.all
    # end

    # def self.find_by_guest(guest_id)
    # end
    #
    # def self.find_by_date(check_in, check_out)
    # end
    #
    # def self.find_by_room(room_id)
    # end

    #def self.find_by_id(reservation_id)
    #end

  end

end

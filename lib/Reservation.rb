require 'pry'
require 'date'
module Hotel

  class Reservation
    attr_accessor :id, :guest, :check_in, :check_out, :room
    attr_reader :all_reservations, :type

    @@all_reservations = []

    def initialize(check_in,check_out,room_id, res_id, guest = nil, type = :standard)
      @id = res_id
      @check_in = Date.parse(check_in) #ruby Date object
      @check_out = Date.parse(check_out) #ruby Date object
      @room= Hotel::Room.find_by_id(room_id) # later, this will be a room object assigned via namespacing method Hotel::Room.find_by(room_id)
      @guest =  guest #Optional- create guest object
      @type = type
    end #end initialize


    def self.all #returns array
      all_reservations = []

      return all_reservations

    end

    def cost
      num_nights_charged * @room.nightly_rate
    end

    def num_nights_charged
      (check_out.mjd - check_in.mjd)
    end

  end

end

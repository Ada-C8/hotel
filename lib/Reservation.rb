require 'pry'
require 'date'
module Hotel

  class Reservation
    attr_accessor :id, :guest, :check_in, :check_out, :room_id
    attr_reader :all_reservations, :type

    def initialize(check_in,check_out,room_id, res_id, discounted_rate = nil, guest = nil)
      @id = res_id
      @check_in = Date.parse(check_in) #ruby Date object
      @check_out = Date.parse(check_out) #ruby Date object
      @room_id= room_id # later, this will be a room object assigned via namespacing method Hotel::Room.find_by(room_id)
      @guest =  guest #Optional- create guest object
      @discounted_rate = discounted_rate
      @type= :standard
    end #end initialize


    def self.all #returns array
      all_reservations = []

      return all_reservations

    end

    ###TODO: CHANGE IMPLEMENTATION OF ROOM COST BELOW

    def cost
      num_nights_charged * 200
    end

    def num_nights_charged
      (check_out.mjd - check_in.mjd)
    end

  end

end

require 'pry'
require 'date'
module HotelBooking

  class Reservation
    attr_accessor :id, :guest, :check_in, :check_out, :room_id
    attr_reader :all_reservations, :type, :rate

    def initialize(check_in,check_out,room_id, res_id, rate = 200, guest = nil)
      @id = res_id
      @check_in = Date.parse(check_in) #ruby Date object
      @check_out = Date.parse(check_out) #ruby Date object
      @room_id= room_id
      @guest =  guest
      @rate = rate
      @type= :standard
    end #end initialize

    def cost
      num_nights_charged * @rate
    end

    def num_nights_charged
      (check_out.mjd - check_in.mjd)
    end

  end

end

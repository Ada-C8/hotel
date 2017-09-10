require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation
    COST = 200 # per night
    attr_reader :guest_name, :dates, :room, :reservation, :cost, :list

    def initialize(guest_name, check_in, check_out)
      @guest_name = guest_name
      @check_in = check_in
      @check_out = check_out
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room = Hotel::Room.new
      @cost = (COST * @dates.length_of_stay).to_i
      @list = {
        :guest_name => @guest_name,
        :check_in => @check_in.to_s,
        :check_out => @check_out.to_s,
        :cost => @cost
      }

      #reservation: [name: date_range, room, cost]
      #sort_by{|k,v|v}
    end # end initialize

    def self.list_all
    end #end #list_all

    def self.list_by_date
    end # end #list_by_date

    def display_reservation
      booking = "Name: #{@guest_name}\nCheck In: #{@check_in}\nCheck Out: #{@check_out}\nRoom Number: #{@room.assign_room}\nTotal Cost: $#{@cost}"

      return booking
    end # end #display_reservation
  end # end of Reservation
end # end of Hotel module

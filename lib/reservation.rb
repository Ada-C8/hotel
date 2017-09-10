require 'pry'

require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation
    COST = 200 # per night
    @@reservations = []
    attr_reader :guest_name, :dates, :room, :cost, :list

    def initialize(guest_name, check_in, check_out)

      @guest_name = guest_name
      @check_in = check_in
      @check_out = check_out
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room = Hotel::Room.new
      @cost = (COST * @dates.length_of_stay).to_i
      @@reservations << self
      # @list = {
      #   :guest_name => @guest_name,
      #   :check_in => @check_in.to_s,
      #   :check_out => @check_out.to_s,
      #   :cost => @cost
      # }
      #
      #reservation: [name: date_range, room, cost]
      #sort_by{|k,v|v} date
    end # end initialize

    def self.reservation
      @@reservations
    end

    def self.print_list
      @@reservations.each do | booking |
        puts "Name: #{booking.guest_name}"


        # puts "Name: #{booking.guest_name}\nCheck In: #{booking.check_in}\nCheck Out: #{booking.check_out}\nRoom Number: #{booking.room.assign_room}\nTotal Cost: $#{booking.cost}"
      end
    end # end #self.print_list
  end # end of Reservation
end # end of Hotel module

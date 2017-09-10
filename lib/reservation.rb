
require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation
    COST = 200 # per night
    @@reservations = []
    attr_reader :guest_name, :check_in, :check_out, :dates, :room, :cost, :list

    def initialize(guest_name, check_in, check_out)

      @guest_name = guest_name
      @check_in = check_in
      @check_out = check_out
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room = Hotel::Room.new
      @cost = (COST * @dates.length_of_stay).to_i
      @@reservations << self
    end # end initialize

    def self.reservation
      @@reservations
    end # end self.reservations

    def self.print_list
      bookings = []
      @@reservations.each do | booking |
        bookings << "Name: #{booking.guest_name}\nCheck In: #{booking.check_in}\nCheck Out: #{booking.check_out}\nRoom Number: #{booking.room.assign_room}\nTotal Cost: $#{booking.cost}"
      end
      return bookings
    end # end #self.print_list

    def self.on_date(date)
      @@reservations.select do | reservation |
        reservation.check_in == date
      end
    end # end #self.on_date
  end # end of Reservation
end # end of Hotel module


require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation # various ways to list reservations
    COST = 200 # per night
    @@reservations = [] # list of all reservations made
    attr_reader :guest_name, :check_in, :check_out, :dates, :room, :cost, :list

    def initialize(guest_name, check_in, check_out, room)
      @guest_name = guest_name
      @check_in = check_in
      @check_out = check_out
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room = room
      @cost = (COST * @dates.length_of_stay).to_i
      @@reservations << self # each new instance put into the list of total reservations
    end # end initialize

    def self.reservations
      @@reservations
    end # end self.reservations

    def self.print_list
      bookings = []
      @@reservations.each do |booking|
        bookings << "Name: #{booking.guest_name}\nCheck In: #{booking.check_in}\nCheck Out: #{booking.check_out}\nRoom Number: #{booking.room}\nTotal Cost: $#{booking.cost}" # turns out you can't use instance variables within a class method
      end
      return bookings
    end # end #self.print_list

    def self.on_date(date) # list reservations on a given date
      @@reservations.select do |reservation|
        reservation.check_in == date
      end
    end # end #self.on_date

    def self.available_rooms(date_range) # list reservations on given date range
      reservations_in_range = @@reservations.reject do |reservation| # excludes reservastions outside date range
        reservation.check_out < date_range.check_in && reservation.check_in > date_range.check_out
      end

      rooms_in_range = reservations_in_range.map do |reservation| # iterates over reservations_in_range and converts each reservation into its room number (instead of list of obj, becomes list of int)
        reservation.room.room_number
      end

      return Hotel::Room.all.reject do |room| # remove from list of rooms without reservations in date range
        rooms_in_range.include?(room.room_number)
      end
    end # end #self.available_rooms
  end # end of Reservation
end # end of Hotel module

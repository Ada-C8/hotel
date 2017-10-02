require_relative 'date_range'
module Hotel
  class Reservation # various ways to list reservations
    # COST = 200 # per night
    # @@reservations = [] # list of all reservations made
    attr_reader :dates, :room, :rate

    def initialize(dates, room, rate)
      @dates = dates
      @room = room
      @rate = 200
      # available_room_numbers = Hotel::Reservation.available_rooms(@dates).map do |room|
        # room.room_number
      # end
      # if !available_room_numbers.include?(@room.room_number)
      #   raise InvalidRoomError.new('This room has already been booked')
      # end # tests if room has already been booked, raises error if so
      # @@reservations << self # each new instance put into the list of total reservations
    end # end initialize

    def final_cost
      return @rate * @dates.number_of_nights.to_i
    end # end final_cost

    # def self.reservations
    #   @@reservations
    # end # end self.reservations

    # def self.print_list
    #   bookings = []
    #   @@reservations.each do |booking|
    #     bookings << "Check In: #{booking.check_in}\nCheck Out: #{booking.check_out}\nRoom Number: #{booking.room.room_number}\nTotal Cost: $#{booking.cost}" # turns out you can't use instance variables within a class method
    #   end
    #   return bookings
    # end # end self.print_list

    # def self.on_date(date) # list reservations on a given date
    #   @@reservations.select do |reservation|
    #     reservation.check_in == date
    #   end
    # end # end self.on_date
    #
    # def self.available_rooms(date_range) # list reservations on given date range
    #   reservations_in_range = @@reservations.reject do |reservation| # excludes reservastions outside date range
    #     reservation.dates.overlap?(date_range)
    #   end
    #
    #   rooms_in_range = reservations_in_range.map do |reservation| # iterates over reservations_in_range and converts each reservation into its room number (instead of list of obj, becomes list of int)
    #     reservation.room.room_number
    #   end
    #
    #   return Hotel::Room.all.reject do |room| # remove from list of rooms without reservations in date range
    #     rooms_in_range.include?(room.room_number)
    #   end
    # end # end self.available_rooms
  end # end of Reservation
end # end of Hotel module

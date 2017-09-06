require_relative 'reservation'

require 'date'


class Hotel
  # @@reservations = []
  attr_reader :rooms

  def initialize
    # array of rooms
    @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @@reservations = []

    # collection of reservations
    # @reservations =
  end

  # reserves an available room for a given date range
  def create_reservation(room, check_in, check_out)
    # check availability of room for date range
    # if
    #   Reservation.new(room, check_in, check_out)
    # else
    # end
    new_reservation = Reservation.new(room, check_in, check_out)
    @@reservations << new_reservation
    return new_reservation

  end

  def self.all_reservations
    return @@reservations
  end

  def self.check_date(date)
    reservations_for_day = []
    Hotel.all_reservations.each do |reservation|
      days = reservation.dates.start
      reservation.dates.nights.to_i.times do
        if date == days
          reservations_for_day << reservation
        end
        days = days.next
      end
    end
    return reservations_for_day
  end

# def add_reservation(chec)
#
# end
# puts Date.new(2001,2,3)
end

# bb = Hotel.new
# check_out = Date.new(2017, 03, 14)
# check_in = Date.new(2017, 03, 11)
# bb.create_reservation(1, check_in, check_out)
#
# check_in = Date.new(2017, 04, 8)
# check_out = Date.new(2017, 04, 11)
# bb.create_reservation(1, check_in, check_out)
#
# puts Hotel.all_reservations
#
# date = Date.new(2017, 03, 12)
# puts Hotel.check_date(date)


# puts Hotel.all_reservations[0]
# test1 = Reservation.new(check_in, check_out)
# test1.add_reservation

#
# check_in = Date.new(2017, 03, 11)
# check_out = Date.new(2017, 04, 11)
# test2 = Reservation.new(check_in, check_out)
# test2.add_reservation
#
# puts Reservation.all
# date = Date.new(2017, 03, 12)
# puts Reservation.check_date(date)

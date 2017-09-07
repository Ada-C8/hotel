require_relative 'reservation'
require_relative 'date_range'


require 'date'


class Hotel
  attr_reader :rooms

  def initialize
    # array of rooms
    @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    # array of reservations
    @reservations = []
  end

  # reserves an available room for a given date range
  def create_reservation(room, check_in, check_out)

    if self.availability(check_in, check_out).include?(room)
      new_reservation = Reservation.new(room, check_in, check_out)
      @reservations << new_reservation
      return new_reservation
    else
      raise ArgumentError.new("That room is not available")
    end
  end

  def all_reservations
    return @reservations
  end

  def get_reservations_for_date(date)
    reservations_for_day = []
    self.all_reservations.each do |reservation|
      if (reservation.dates.start...reservation.dates.end).include?(date)
        # if reservation.dates.include?(date, reservation)
        reservations_for_day << reservation
      end
    end
    return reservations_for_day
  end

  # check availability of rooms for a certain date range
  def availability(check_in, check_out)
    reservations_for_range = []
    reserved_rooms = []
    date_range = DateRange.new(check_in, check_out)
    @reservations.each do |reservation|
      if (reservation.dates.start...reservation.dates.end).cover?(date_range.start) || (reservation.dates.start...reservation.dates.end).cover?(date_range.end)
        reservations_for_range << reservation
      end
    end
    reservations_for_range.each do |reservation|
      reserved_rooms << reservation.room
    end
    available_rooms = @rooms - reserved_rooms
    # puts available_rooms
    return available_rooms
    # date_range.start >= add
    #   day_to_check = date_range.start
    #   date_range.nights.to_i.times do
    #     reservations_for_range << [*get_reservations_for_date(day_to_check)]
    #
    #     day_to_check = day_to_check.next
    #   end
    #   reservations_for_range = *reservations_for_range
    #
    #   reservations_for_range.each do |reservation|
    #     if !(reservation.empty?)
    #       reserved_rooms << reservation[0].room
    #     end
    #   end
    #   available_rooms = @rooms - reserved_rooms.uniq
    #   return available_rooms
    # end

    # def add_reservation(chec)
    #
    # end
    # puts Date.new(2001,2,3)
  end
end

  # bb = Hotel.new
  # check_out = Date.new(2017, 03, 14)
  # check_in = Date.new(2017, 03, 11)
  # bb.create_reservation(1, check_in, check_out)
  #
  # check_in = Date.new(2017, 04, 8)
  # check_out = Date.new(2017, 04, 11)
  # bb.create_reservation(2, check_in, check_out)
  #
  # puts bb.all_reservations
  #
  # date = Date.new(2017, 03, 12)
  # puts bb.check_date(date)
  # check_in = Date.new(2017, 04, 11)
  # check_out = Date.new(2017, 04, 13)
  # bb.create_reservation(2, check_in, check_out)
  # puts bb.all_reservations

  #
  # check_in = Date.new(2017, 04, 9)
  # check_out = Date.new(2017, 04, 13)
  # print bb.availability(check_in, check_out)

  ###################

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


  # #rename get_Reservations
  # def get_reservations_for_date(date)
  #   reservations_for_day = []
  #   self.all_reservations.each do |reservation|
  #     if  date >= reservation.dates.start && date < reservation.dates.end
  #       #   days = reservation.dates.start
  #       #   reservation.dates.nights.to_i.times do
  #       #     if date == days
  #       reservations_for_day << reservation
  #       #     end
  #       #     days = days.next
  #       #   end
  #     end
  #   end
  #   return reservations_for_day
  #
  # end

  # def availability(check_in, check_out)
  #   reservations_for_range = []
  #   reserved_rooms = []
  #   date_range = DateRange.new(check_in, check_out)
  #   day_to_check = date_range.start
  #   date_range.nights.to_i.times do
  #     reservations_for_range << [*get_reservations_for_date(day_to_check)]
  #
  #     # reservations_for_range << [*check_date(day_to_check)]
  #     day_to_check = day_to_check.next
  #   end
  #   reservations_for_range = *reservations_for_range
  #   # print reservations_for_range
  #   reservations_for_range.each do |reservation|
  #     if !(reservation.empty?)
  #       reserved_rooms << reservation[0].room
  #       # handle if nil scenario return no reservations
  #     end
  #   end
  #   available_rooms = @rooms - reserved_rooms.uniq
  #   return available_rooms
  #   # return *reservations_for_range
  # end

  # get reservations for a given date
  # def get_reservations_for_date(date)
  #   reservations_for_day = []
  #   self.all_reservations.each do |reservation|
  #     if  date >= reservation.dates.start && date < reservation.dates.end
  #       reservations_for_day << reservation
  #     end
  #   end
  #   return reservations_for_day
  # end

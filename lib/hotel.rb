# require_relative 'reservation'
# require_relative 'date_range'
require_relative 'block'

require 'date'
# require 'pry'


class Hotel
  attr_reader :rooms

  def initialize
    # array of rooms
    @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    # array of reservations
    @reservations = []
    #array of blocks
    @blocks = []
  end

  # reserves an available room for a given date range
  def create_reservation(room, check_in, check_out)
    # print @blocks
    if availability(check_in, check_out).include?(room)
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

  def all_blocks
    return @blocks
  end

  def get_reservations_for_date(date)
    reservations_for_day = []
    all_reservations.each do |reservation|
      if (reservation.dates.start...reservation.dates.end).include?(date)
        # if reservation.dates.include?(date, reservation)
        reservations_for_day << reservation
      end
    end
    return reservations_for_day
  end

  # check availability of rooms for a certain date range
  def availability(check_in, check_out)
    reserved_rooms = []
    blocked_rooms = []
    # available_rooms = []
    date_range = DateRange.new(check_in, check_out)
    @reservations.each do |reservation|
      if ((reservation.dates.start < date_range.end) && (date_range.start < reservation.dates.end))
        # if (reservation.dates.start...reservation.dates.end).cover?(date_range.start) || (reservation.dates.start...reservation.dates.end).cover?(date_range.end)
        reserved_rooms << reservation.room
        # end
      end
    end
    # puts reserved_rooms
    puts @blocks
    @blocks.each do |block|
      # puts date_range.end
      # (x.first < y.last) and (y.first < x.last)
      if ((block.dates.start < date_range.end) && (date_range.start < block.dates.end))
        #   if (block.dates.start...block.dates.end).cover?(date_range.start) || (block.dates.start...block.dates.end).cover?(date_range.end)
        #     puts block
        block.rooms.each do |room|
          blocked_rooms << room
        end
      end
    end
    print blocked_rooms
    # puts blocked_rooms
    # puts @blocks
    # blocked_rooms = *blocked_rooms
    # print blocked_rooms
    # puts blocked_rooms
    available_rooms = @rooms - reserved_rooms - blocked_rooms
    # available_rooms = available_rooms - blocked_rooms
    # available_rooms = @rooms - reserved_rooms
    print available_rooms
    return available_rooms
  end

  # creates a block for a given date range if rooms are available
  def create_block(rooms, check_in, check_out)
    # print room
    rooms.each do |room|
      # print ind_room
      if !(availability(check_in, check_out).include?(room))
        raise ArgumentError.new("That room is not available as a block")
      end
    end
    new_block = Block.new(rooms, check_in, check_out)
    @blocks << new_block
    return new_block
  end

end

# # check availability of rooms for a certain date range
# def availability(check_in, check_out)
#   reservations_for_range = []
#   reserved_rooms = []
#   date_range = DateRange.new(check_in, check_out)
#   @reservations.each do |reservation|
#     if (reservation.dates.start...reservation.dates.end).cover?(date_range.start) || (reservation.dates.start...reservation.dates.end).cover?(date_range.end)
#       reservations_for_range << reservation
#     end
#   end
#   reservations_for_range.each do |reservation|
#     reserved_rooms << reservation.room
#   end
#   available_rooms = @rooms - reserved_rooms
#   return available_rooms
# end

bb = Hotel.new
check_out = Date.new(2017, 03, 14)
check_in = Date.new(2017, 03, 11)
bb.create_reservation(1, check_in, check_out)

check_in = Date.new(2017, 04, 8)
check_out = Date.new(2017, 04, 11)
bb.create_reservation(2, check_in, check_out)

puts bb.all_reservations

# check_in = Date.new(2017, 04, 17)
# check_out = Date.new(2017, 04, 20)

check_in = Date.new(2017, 04, 11)
check_out = Date.new(2017, 04, 15)
bb.create_block([3,2,5], check_in, check_out)

# puts bb.all_blocks[0].dates.start
# puts bb.all_blocks[0].dates.end


# puts bb.all_blocks[0].room

puts bb.all_reservations

check_in = Date.new(2017, 04, 10)
check_out = Date.new(2017, 04, 16)
puts bb.availability(check_in, check_out)

# check_in = Date.new(2017, 04, 14)
# check_out = Date.new(2017, 04, 18)
# bb.create_block([14,3,19], check_in, check_out)
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

#
#   # check availability of rooms for a certain date range
#   def availability(check_in, check_out)
#     reservations_for_range = []
#     reserved_rooms = []
#     date_range = DateRange.new(check_in, check_out)
#     @reservations.each do |reservation|
#       if (reservation.dates.start...reservation.dates.end).cover?(date_range.start) || (reservation.dates.start...reservation.dates.end).cover?(date_range.end)
#         reservations_for_range << reservation
#       end
#     end
#     reservations_for_range.each do |reservation|
#       reserved_rooms << reservation.room
#     end
#     available_rooms = @rooms - reserved_rooms
#     # puts available_rooms
#     return available_rooms
#     # date_range.start >= add
#     #   day_to_check = date_range.start
#     #   date_range.nights.to_i.times do
#     #     reservations_for_range << [*get_reservations_for_date(day_to_check)]
#     #
#     #     day_to_check = day_to_check.next
#     #   end
#     #   reservations_for_range = *reservations_for_range
#     #
#     #   reservations_for_range.each do |reservation|
#     #     if !(reservation.empty?)
#     #       reserved_rooms << reservation[0].room
#     #     end
#     #   end
#     #   available_rooms = @rooms - reserved_rooms.uniq
#     #   return available_rooms
#     # end
#
#     # def add_reservation(chec)
#     #
#     # end
#     # puts Date.new(2001,2,3)
#   end
# end

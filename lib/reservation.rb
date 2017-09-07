require_relative 'date_range'

class Reservation
  # @@reservations = []
  attr_reader :total_cost, :dates, :room

  def initialize(room, check_in, check_out)
    @room = room
    @dates = DateRange.new(check_in, check_out)
    @price_night = 200
    @total_cost = @price_night * @dates.nights
  end


  

  # def add_reservation
  #   @@reservations << self
  # end
  #
  # def self.all
  #   return @@reservations
  # end

# end

# returns all reservations for a specific date
# def self.check_date(date)
#   reservations_for_day = []
#   Reservation.all.each do |reservation|
#     days = reservation.dates.start
#     # puts days
#     # # days = days.next
#     # # puts days
#     # puts reservation.dates.nights
#     reservation.dates.nights.to_i.times do
#       if date == days
#         reservations_for_day << reservation
#         # reservations_for_day << reservation.room
#       end
#       days = days.next
#     end
#   end
#   return reservations_for_day
# end
# end

# check_out = Date.new(2017, 03, 14)
# check_in = Date.new(2017, 03, 11)
# test1 = Reservation.new(check_in, check_out)
# test1.add_reservation
#
#
# check_in = Date.new(2017, 03, 11)
# check_out = Date.new(2017, 04, 11)
# test2 = Reservation.new(check_in, check_out)
# test2.add_reservation
#
# puts Reservation.all
# date = Date.new(2017, 03, 12)
# puts Reservation.check_date(date)

# def check_date(date)
# Reservation.all.each_with_index do |reservation, i|
#   reservation.dates.nights.times do |reservation_days|
#     if date == reservation_days
#
#       @reservations_for_day << reservation
#     else
#
#     end
#
#   end
#
#
#
end
# puts Reservation.all[0].dates.start+1

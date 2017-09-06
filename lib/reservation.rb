require_relative 'date_range'

class Reservation
  @@reservations = []
  attr_reader :total_cost, :dates

  def initialize(check_in, check_out)
    @dates = DateRange.new(check_in, check_out)
    @price_night = 200
    @total_cost = @price_night * @dates.nights
  end

  def add_reservation
    @@reservations << self
  end

  def self.all
    return @@reservations
  end

end

check_out = Date.new(2017, 03, 14)
check_in = Date.new(2017, 03, 11)
test1 = Reservation.new(check_in, check_out)
test1.add_reservation


check_in = Date.new(2017, 03, 11)
check_out = Date.new(2017, 04, 11)
test2 = Reservation.new(check_in, check_out)
test2.add_reservation


puts Reservation.all.length

puts Reservation.all[0].dates.start

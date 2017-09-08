# require_relative 'reservation'
require 'date'

class DateRange
  attr_reader :nights, :start, :end
  def initialize(check_in, check_out)
    @start = check_in
    @end = check_out
    @nights = (check_out-check_in)

    if @end <= @start
      raise ArgumentError.new("This is an invalid check-in/check-out combination")
    end
    
  end

  def include?(date)
    if (self.start...self.end).include?(date)
      return true
    else
      return false
    end
  end

end


  # def overlap?(date_range, reservation)
  #
  #   def overlaps?(other)
  #     self.cover?(other.first) || other.cover?(first)
  #   end
  #   # if date >= reservation.dates.start && date < reservation.dates.end
  #   #
  #   # end
  #
  # end






      # if date >= reservation.dates.start && date < reservation.dates.end
      #   return true
      # else
      #   return false
      # end

  # def include?
  # Reservation.check_date(self.start)
  #   Reservation.all.each_with_index do |reservation, i|
  #     reservation.dates.nights.times do
  #       if date == reservation.next
  #
  #         reservation.next << reservation
  #       else
  #
  #       end
  #
  #     end
  #   end
  # end
  #
  # def overlap?
  #
  # end

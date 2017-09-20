require 'date'

module Administration
  class Reservation

    RATE = 200

    attr_reader :check_in, :check_out, :room

    def initialize(check_in, check_out, room)
      @check_in = check_in
      @check_out = check_out
      @room = room

      raise ArgumentError.new("Check in must be a date") unless @check_in.is_a? Date
      raise ArgumentError.new("Check out must be a date") unless @check_out.is_a? Date
      raise ArgumentError.new("Check in date must be before check out date") if @check_out < @check_in
      raise ArgumentError.new("Enter a valid date range") if @check_in == @check_out
    end

    def total_nights
      total_nights = (@check_out - @check_in)
      return total_nights.ceil
    end

    def total_cost
      total_cost = (total_nights * RATE)
      return total_cost
    end

    def reserved?(target_date)
      return target_date >= @check_in && target_date < @check_out
    end

    def overlap?(other)
      #if the start date for other falls within the self date range, then reservations overlap
      #if the start date for self falls within the other date range, then reservations overlap
      self.reserved?(other.check_in) || other.reserved?(self.check_in)
    end





  end #reservation
end #module

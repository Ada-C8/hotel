require_relative 'hotel'

class Nights
  attr_reader :check_in, :check_out, :num_nights, :nights_reserved
  def initialize(check_in, check_out)
    valid_date(check_in, check_out)

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    #@check_out = Date.parse(check_out)
    @nights_reserved = populate_nights(@check_in, @check_out)
    @num_nights = @nights_reserved.length
  end

  def populate_nights(check_in, check_out)
    nights = []
    until check_in == check_out
      nights.push(check_in.to_s)
      check_in += 1
    end
    return nights
  end

  def num_nights
    @nights_reserved.length
  end

  private
  def valid_date(check_in, check_out)
    start = Date.parse(check_in)
    finish = Date.parse(check_out)

    if start.nil? || finish.nil?
      raise ArgumentError.new("Invalid Input")
    elsif finish <= start
      raise ArgumentError.new("Invalid date range. Checkout date must be after check-in date.")
    elsif start < Date.today
      raise ArgumentError.new("That date has already passed. Please select a valid check-in date.")
    end
  end
end

require 'date'

class Reservation
  attr_reader :check_in, :check_out, :nights, :bill
  def initialize(check_in, check_out, rate)
    valid_date(check_in, check_out)

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @nights = (@check_out-@check_in).to_i
    @bill = @nights * rate
  end


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

# begin
#   # here is the code that could raise ArgumentError
# rescue ArgumentError
#   puts "there was an error"
# else
#   puts "no error"
# end

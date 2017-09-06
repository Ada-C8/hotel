module Hotel
  class Reservation

  attr_reader :total_nights, :check_in, :check_out

  def initialize(guest, check_in, check_out)
    @guest = guest
    @check_in = check_in_date(check_in)
    @check_out = check_out_date(check_out)
    @total_nights = calculate_res_length
  end

  # Reservations that are checking out on that date will return false since they are not staying that night at the hotel
  def include_date?(date)
    date.between?(@check_in, @check_out - 1)
  end

  private

  def check_in_date(check_in)
    if check_in.is_a? (Date)
      @check_in = check_in
    else
      raise ArgumentError.new "check_in must be a Date"
    end
  end

  def check_out_date(check_out)
    if check_out.is_a? (Date)
      @check_out = check_out
    else
      raise ArgumentError.new "check_out must be a date"
    end
  end

  def calculate_res_length
    if @check_in >= @check_out || @check_in < Date.today
      raise ArgumentError.new "invalid dates"
    else
      length = @check_out - @check_in
      return length.to_i
    end
  end

  end #end of Reservation class
end #end of Hotel module

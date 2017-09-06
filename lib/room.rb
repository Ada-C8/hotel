require_relative 'hotel'

module Hotel
  class Room
    attr_reader :id, :cost
    def initialize(input_id, cost)
      @id = input_id
      @cost = cost
    end # => end of initialize

    # def is_available?(begin_date, end_date)
    #   @availablility.each do |reservation_id, dates|
    #     if (begin_date >= check_in) && (begin_date <= check_out) || (end_date >= check_in) && (end_date <= check_out)

  end # => end of class
end # => end of module

require_relative 'date_range'
module My_Hotel
  class Reservation

    attr_reader :reservation_id, :block_id, :date_range

    def initialize(start_date,end_date)
      @start_date = start_date
      @end_date = end_date
      @reservation_id = 1
      @date_range = My_Hotel::Date_Range.new(@start_date, @end_date).date_range
      @block_id = 1
    end

    # def get_date_range
    #   My_Hotel::Date_Range.new(@start_date, @end_date).date_range
    # end

    # def set_id
    #   make a random id number for the reservation
    #   make sure it is random
    # end

    # def cost_reservation
    #   number of dates * Room.rate = sum
    # end

    # def cancel_reservation
    # end

    #  def self.all
    #    puts
    #  end

  end
end

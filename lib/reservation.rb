module Hotel

  class Reservation
    attr_reader :start_date, :end_date, :dates #block

    def initialize(start_date, end_date) # block = :false
      @start_date = start_date
      @end_date = end_date
      @dates = (@start_date..@end_date).map(&:to_s)
      # add a unique id
    end

  end #end of Reservation
end #end of Hotel

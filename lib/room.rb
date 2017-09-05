module Hotel
  class Room

    attr_reader :available, :check_in_date, :check_out_date, :cost

    def initialize
      @available = true
      # @blocked_off = false #for Wave 3
      @check_in_date = nil
      @check_out_date = nil
      @cost = 200
    end

  end
end

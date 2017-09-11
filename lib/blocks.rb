module Hotel
  class Blocks
    attr_reader :date_range, :rooms, :discounted_rate
    def initialize(check_in,check_out)
      @date_range = Hotel::DateRange.new(check_in,check_out)
      @rooms = []
      @discounted_rate = 0.2
    end

  end
end

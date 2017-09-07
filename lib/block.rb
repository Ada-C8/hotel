module Hotel
  class Block
    attr_reader :partyname, :daterange, :discounted_rate, :rooms

    def initialize(partyname, date1, *date2, discounted_rate, rooms)
      @party_name = partyname
      @daterange = DateRange.new(date1, *date2)
      @rate = discounted_rate
      @rooms = rooms
    end

  end
end

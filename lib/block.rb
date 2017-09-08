module Hotel
  class Block
    attr_reader :partyname, :daterange, :discounted_rate, :rooms

    def initialize(partyname, discounted_rate, rooms, date1, date2=nil)
      @party_name = partyname
      @daterange = DateRange.new(date1, *date2)
      @rate = discounted_rate
      @rooms = rooms
    end

  end
end

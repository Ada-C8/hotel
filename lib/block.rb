module Hotel
  class Block
    attr_reader :partyname, :daterange, :discountedrate, :rooms

    def initialize(partyname, discountedrate, rooms, date1, date2=nil)
      @partyname = partyname
      @daterange = DateRange.new(date1, *date2)
      @discountedrate = discountedrate
      @rooms = rooms
    end

  end
end

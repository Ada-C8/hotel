# require_relative 'hotel'
require_relative 'room'
require 'date'

module Hotel
  PRICE_PER_NIGHT = 200

  class Reservation

    attr_accessor :date_range, :room, :name, :contact_info, :price

    def  initialize(date_range, room, name, contact_info)
      @date_range = date_range
      @room = room
      @name = name
      @contact_info = contact_info
      @price = date_range.length * PRICE_PER_NIGHT
    end

    def dates
      dates_reserved = []
      @date_range.each_entry{|date| dates_reserved << date}
      dates_reserved
    end #end available?

  end#end class
end#end module

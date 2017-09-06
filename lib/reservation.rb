require_relative 'hotel'
require_relative 'room'
require 'date'

module Hotel
  PRICE_PER_NIGHT = 200

  class Reservation

    attr_accessor :date_range, :room, :name, :contact_info, :price

    def  initialize(date_range, room, name, contact_info)
      @dates = date_range
      @room = room
      @name = name
      @contact_info = contact_info
      @price = date_range.length * PRICE_PER_NIGHT
    end

    def dates
      dates_reserved = []
      dates_reserved << @dates.each
    end #end available?

  end#end class
end#end module

require_relative 'hotel'

module Hotel

  class Reservation

    attr_accessor :date_range, :room, :name, :contact_info

    def  initialize(date_range, room, name, contact_info)
      @date = date_range
      @room = room
      @name = name
      @contact_info = contact_info
    end

    def available?(date)
      @date == date ? false : true
    end #end available?

  end#end class
end#end module

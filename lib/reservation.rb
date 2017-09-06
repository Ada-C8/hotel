# require_relative 'hotel'
require_relative 'room'
require 'date'
require 'pry'

module Hotel
PRICE_PER_NIGHT = 200

  def Hotel.get_date_range(check_in, check_out)
    return  (Date.new(check_in) ... Date.new(check_out)).to_a
  end

  class Reservation

    attr_accessor :date_range, :room, :name, :contact_info, :check_in, :check_out

    def  initialize(check_in, check_out, room, name, contact_info)

      @check_in = Date.new(check_in)
      @check_out = Date.new(check_out)
      @date_range = get_date_range(check_in, check_out)
      @room = room
      @name = name
      @contact_info = contact_info
      @price = (@date_range.length) * PRICE_PER_NIGHT
    end


      def get_date_range(check_in, check_out)
        return  (Date.new(check_in) ... Date.new(check_out)).to_a
      end
      
    def self.nights_reserved
      @date_range
    end #end available?

  end#end class
    # binding.pry
end#end module

# require_relative 'hotel'
require_relative 'room'
require 'date'
require 'pry'

module Hotel
  PRICE_PER_NIGHT = 200

  #
  # def get_date_range(check_in, check_out)
  #   return  (Date.new(check_in[0], check_in[1], check_in[2]) ... Date.new(check_out[0], check_out[1], check_out[2])).to_a
  # end


  class Reservation

    attr_accessor :date_range, :room, :name, :contact_info, :check_in, :check_out, :price

    def  initialize(check_in, check_out, room, name, contact_info)

      @check_in = Date.new(check_in[0], check_in[1], check_in[2])
      @check_out = Date.new(check_out[0], check_out[1], check_out[2])
      @date_range = populate_date_range(@check_in, @check_out)
      @room = room
      @name = name
      @contact_info = contact_info
      @price = (@date_range.length) * PRICE_PER_NIGHT

    end



    def get_date_range(check_in, check_out)
      return  (check_in ... check_out).to_a
    end

    def populate_date_range(check_in, check_out)
      get_date_range(check_in, check_out)
    end

    def dates_reserved
      @date_range
    end #end available?

  end#end class
  # binding.pry
end#end module

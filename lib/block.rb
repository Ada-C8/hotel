# block
require 'date'

module HotelManagment
  class Block
    attr_reader :amount_of_rooms

    BLOCKRATE = 100

    def initialize(check_in_date, check_out_date, amount_of_rooms)
      @amount_of_rooms = amount_of_rooms
    end

  end #class end
end #module end

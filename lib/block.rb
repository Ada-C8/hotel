# block
require 'date'

module HotelManagment
  class Block
    attr_reader :amount_of_rooms, :check_in_date, :check_out_date

    BLOCKRATE = 100

    def initialize(check_in_date, check_out_date, amount_of_rooms)
      @amount_of_rooms = amount_of_rooms
      @check_in_date = check_in_date
      @check_out_date = check_out_date
    end

  end #class end
end #module end

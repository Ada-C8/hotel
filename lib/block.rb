# block
require 'date'

module HotelManagment
  class Block
    attr_reader :amount_of_rooms, :check_in_date, :check_out_date
    attr_accessor :rooms

    BLOCKRATE = 100

    def initialize(check_in_date, check_out_date, amount_of_rooms)
      @amount_of_rooms = amount_of_rooms
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @rooms = []
    end

  end #class end
end #module end

# block
require 'date'
require 'securerandom'

module HotelManagment
  class Block
    attr_reader :amount_of_rooms, :check_in_date, :check_out_date, :id
    attr_accessor :rooms

    BLOCKRATE = 100

    def initialize(check_in_date, check_out_date, amount_of_rooms)
      @amount_of_rooms = amount_of_rooms
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @rooms = []
      @id = SecureRandom.uuid
    end

    def validate
      if amount_of_rooms > 5
        raise ArgumentError, '5 rooms is the Maximum a block allows'
      end
    end

  end #class end
end #module end

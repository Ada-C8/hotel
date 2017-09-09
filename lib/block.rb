#block.rb

require 'awesome_print'
require 'date'
require 'pry'

module Hotel_Chain
  class Block

    attr_reader :party_name, :check_in_date, :check_out, :room_rate, :reservations_array

    def initialize(party_name, check_in_date, check_out_date, room_rate, reservations_array)
      @party_name = party_name
      @check_in_date = Date.strptime(check_in_date, "%m/%d/%Y")
      @check_out_date = Date.strptime(check_out_date, "%m/%d/%Y")
      @room_rate = room_rate
      @reservations_array = reservations_array #array of reservation objects
    end

  end #end of class
end #end of module

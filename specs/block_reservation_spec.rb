require_relative 'spec_helper'
require 'date'


describe "Reservaton Class" do



  describe "block_rate Method" do

    it "Must respond to block_rate" do
      new_reservation = HotelManagment::BlockReservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.must_respond_to :block_rate
    end



    it "should return the total cost based on the number of nights reserved" do

      new_reservation = HotelManagment::BlockReservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.block_rate.must_equal 500

    end
  end
end

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/reservations'
require_relative './spec_helper.rb'

describe "Reservations Wave 1" do

  describe "Initialize" do

    it "can initialize a reservation" do
      room = Hotels::Rooms.new(1)
      date_range = [(Date.new(2020, 9, 10)), (Date.new(2020, 9, 11))]
      new_res = Hotels::Reservations.new(room, date_range)

      new_res.must_be_instance_of Hotels::Reservations
      new_res.room.must_be_instance_of Hotels::Rooms
    end

    it "can get total cost of reservation" do
      room = Hotels::Rooms.new(1)
      date_range = [(Date.new(2020, 9, 10)), (Date.new(2020, 9, 11))]
      new_res = Hotels::Reservations.new(room, date_range)

      new_res.calculate_bill.must_equal 400
    end
  end
end

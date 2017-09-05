require_relative 'spec_helper'

module Hotel
  class Room
    def self.clear
      @@rooms = []
    end
  end
end

describe "Reservation class" do
  before do
    @min = 1
    @max = 20
    (@min..@max).each { |num| Hotel::Room.new(num) }
  end

  after do
    Hotel::Room.clear
  end

  it "can create a new reservation for a room and date range" do
    #either by leaving the initialization arguments blank
    Hotel::Reservation.new().must_be_instance_of Hotel::Reservation

    #or by specifying a date range
    Hotel::Reservation.new(Date.new(2017, 7, 1), Date.new(2017, 7, 5)).must_be_instance_of Hotel::Reservation

    #or by specifying both a date range and room number
    Hotel::Reservation.new(Date.new(2017, 7, 1), Date.new(2017, 7, 5), 20).must_be_instance_of Hotel::Reservation
  end

  it "can calculate the final rate of the reservation" do
    Hotel::Room.all.length
  end

  xit "can provide information about reservations on a specific date" do

  end

end

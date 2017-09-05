require_relative 'spec_helper'

module Hotel
  class Room
    def self.clear
      @@rooms = []
    end
  end

  class Reservation
    def self.clear
      @@reservations = []
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
    Hotel::Reservation.clear
  end

  it "can create a new reservation for a room and date range" do
    #either by leaving the initialization arguments blank
    Hotel::Reservation.new().must_be_instance_of Hotel::Reservation

    #or by specifying a date range
    Hotel::Reservation.new(Date.new(2017, 7, 1), Date.new(2017, 7, 5)).must_be_instance_of Hotel::Reservation

    #or by specifying both a date range and room number
    Hotel::Reservation.new(Date.new(2017, 7, 1), Date.new(2017, 7, 5), 20).must_be_instance_of Hotel::Reservation
  end

  it "can calculate the total cost of the reservation" do
    reservation = Hotel::Reservation.new(Date.new(2017, 7, 1), Date.new(2017, 7, 5))
    reservation.total.must_equal 800
  end

  it "can provide information about reservations on a specific date" do
    Hotel::Reservation.new(Date.new(2017, 7, 1), Date.new(2017, 7, 5), 1)

    Hotel::Reservation.all(Date.new(2017, 7, 1)).must_be_instance_of Array
    Hotel::Reservation.all(Date.new(2017, 7, 1)).length.must_equal 1
    Hotel::Reservation.all(Date.new(2017, 7, 1))[0].must_be_instance_of Hotel::Reservation

    Hotel::Reservation.new(Date.new(2017, 9, 1), Date.new(2017, 9, 5), 2)

    Hotel::Reservation.all(Date.new(2017, 9, 1)).must_be_instance_of Array
    Hotel::Reservation.all(Date.new(2017, 9, 1)).length.must_equal 1
    Hotel::Reservation.all(Date.new(2017, 9, 1))[0].must_be_instance_of Hotel::Reservation

    Hotel::Reservation.all().must_be_instance_of Array
    Hotel::Reservation.all().length.must_equal 2
    Hotel::Reservation.all().each { |reservation| reservation.must_be_instance_of Hotel::Reservation }
  end

  it "can reserve a room for a given date range" do
    Hotel::Reservation.new(Date.new(2017, 7, 1), Date.new(2017, 7, 5), 1)
    Hotel::Reservation.all(Date.new(2017, 7, 1))[0].start_date.must_equal Date.new(2017, 7, 1)
    Hotel::Reservation.all(Date.new(2017, 7, 1))[0].end_date.must_equal Date.new(2017, 7, 5)
    Hotel::Reservation.all(Date.new(2017, 7, 1))[0].room_num.must_equal 1
  end
end

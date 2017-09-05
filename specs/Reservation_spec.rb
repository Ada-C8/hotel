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
    Hotel::Reservation.new(Date.today, Date.today + 1).must_be_instance_of Hotel::Reservation

    #or by specifying both a date range and room number
    Hotel::Room.new(21)
    Hotel::Reservation.new(Date.today, Date.today + 1, 21).must_be_instance_of Hotel::Reservation
  end

  it "can calculate the total cost of the reservation" do
    reservation = Hotel::Reservation.new(Date.today, Date.today + 4)
    reservation.total.must_equal 800
  end

  it "can provide information about reservations on a specific date" do
    Hotel::Reservation.new(Date.today, Date.today + 1, 1)

    Hotel::Reservation.all(Date.today).must_be_instance_of Array
    Hotel::Reservation.all(Date.today).length.must_equal 1
    Hotel::Reservation.all(Date.today)[0].must_be_instance_of Hotel::Reservation

    Hotel::Reservation.new(Date.today + 2, Date.today + 3, 2)

    Hotel::Reservation.all(Date.today + 2).must_be_instance_of Array
    Hotel::Reservation.all(Date.today + 2).length.must_equal 1
    Hotel::Reservation.all(Date.today + 2)[0].must_be_instance_of Hotel::Reservation

    Hotel::Reservation.all().must_be_instance_of Array
    Hotel::Reservation.all().length.must_equal 2
    Hotel::Reservation.all().each { |reservation| reservation.must_be_instance_of Hotel::Reservation }
  end

  it "can reserve a room for a given date range" do
    Hotel::Reservation.new(Date.today, Date.today + 1, 1)
    Hotel::Reservation.all(Date.today)[0].start_date.must_equal Date.today
    Hotel::Reservation.all(Date.today)[0].end_date.must_equal Date.today + 1
    Hotel::Reservation.all(Date.today)[0].room_num.must_equal 1
  end

  it "raises an exception if the date range includes non-date values" do
    proc{Hotel::Reservation.new(Date.today.to_s, Date.today + 1)}.must_raise Exception
  end

  it "raises an exception if the end date is after the start date" do
    proc{Hotel::Reservation.new(Date.today, Date.today - 1)}.must_raise Exception
  end

  it "raises an exception if the start date is before today's date" do
    proc{Hotel::Reservation.new(Date.today - 1, Date.today)}.must_raise Exception
  end
end

require_relative 'spec_helper'

require 'date'

describe "Hotel" do
  let(:hotel) { Hotel::Hotel.new }
  let(:smith) { hotel.new_reservation("2017-10-01", "2017-10-04", 2) }
  let(:garcia) { hotel.new_reservation("2017-10-02", "2017-10-06", 4) }
  let(:jones) { hotel.new_reservation("2017-10-02", "2017-10-04", 5) }

  describe "initialize" do
    it "creates a Hotel instance" do
      hotel.must_respond_to :rooms
    end

    it "provides a list of all reservations" do
      hotel.reservations.must_be_instance_of Array
      hotel.reservations.length.must_equal 0
    end

    it "provides a list of all rooms" do
      hotel.rooms.must_be_instance_of Array
      hotel.rooms.length.must_equal 20
      hotel.rooms[18].number.must_equal 19
    end
  end


describe "new_reservation" do
  before do
    hotel
    smith
    garcia
    jones
  end

  it "returns an Array of Reservation objects" do
    hotel.reservations.each { |reserv| reserv.must_be_instance_of Hotel::Reservation }
    hotel.reservations[0].checkin.must_equal Date.new(2017, 10, 1)
  end
end

describe "reservations_on" do
  it "provides a list of all reservations on a given date" do
    smith
    garcia
    jones

    hotel.reservations_on("2017-10-02").must_be_instance_of Array
    hotel.reservations_on("2017-10-02").length.must_equal 3

    hotel.reservations_on("2017-10-05").length.must_equal 1
  end
end
end

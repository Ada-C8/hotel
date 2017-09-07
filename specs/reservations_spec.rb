require_relative '../lib/reservation'
require_relative 'spec_helper'

describe "reservation" do

  it "can initialize a reservation" do
    reservation_1 = Hotel::Reservation.new( [2019, 11, 15], [2019, 11, 15], 4, "T Payne", "8675309" )
    reservation_1.must_be_instance_of Hotel::Reservation
  end

  it "can return the correct information" do

    reservation_1 = Hotel::Reservation.new( [1900, 02, 20], [1900, 02, 22], 3, "Dr. Frankenstein", "8675309" )
    reservation_1.nights_reserved.length.must_equal 1
    reservation_1.room.must_equal 2
    reservation_1.name.must_equal "Mary Shelley"
    reservation_1.contact_info.must_equal "8675309"
    reservation_1.price.must_equal 400
  end
end

describe "nights_reserved method" do
  it "can get dates from reservation" do
    reservation_1 = Hotel::Reservation.new([2019, 11, 15], [2019, 11, 15], 7, "Dr. Frankenstein", "8675309" )
    range_dates = reservation_1.nights_reserved
    puts range_dates[0]
    range_dates[0].must_equal 1
  end
end
